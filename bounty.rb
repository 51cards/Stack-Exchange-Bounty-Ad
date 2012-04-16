#!/usr/bin/env ruby

require 'rubygems'
require 'RMagick'

def bounty_image(path, bounties, reputation)  
  bg = Magick::ImageList.new('./resources/bottom.png')
  fg = Magick::ImageList.new('./resources/top.png')
  values = Magick::Draw.new
  gravity = Magick::NorthWestGravity
  bountyCountFont = './resources/Helvetica.ttf'
  repFont = './resources/Anonymous Pro B.ttf'

  # Doing the lower value first, otherwise the kerning value in the bounty count screws up the bounty value
  values.annotate(bg, 40, 40, 104, 212, reputation.to_s) do
    self.pointsize = 21
    self.font = repFont
    self.stroke = 'transparent'
    self.fill = '#3B3B3B'
    self.gravity = gravity
  end

  values.annotate(bg, 40, 40, 41, 70, ('%02d' % bounties.to_s)) do
    self.pointsize = 89
    self.font = bountyCountFont
    self.font_family = 'Helvetica'
    self.stroke = 'transparent'
    self.fill = '#2F2F2F'
    self.gravity = gravity
    self.kerning = 41
  end

  bg.composite_layers(fg).write(path)
end
