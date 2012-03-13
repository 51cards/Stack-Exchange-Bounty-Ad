#!/usr/bin/env ruby

require 'rubygems'
require 'RMagick'
require 'serel'

Serel::Base.config(:apple, 'y6kJ2wLn7yuN7ilUOvBRPw((')

bounties = Serel::Question.featured.request

rep = 0
i = 0

bounties.each do |t|
	rep += t.bounty_amount
	i += 1
end

bg = Magick::ImageList.new('./bottom.png')
fg = Magick::ImageList.new('./top.png')
values = Magick::Draw.new
gravity = Magick::NorthWestGravity
bountyCountFont = "Helvetica.ttf"
repFont = "Anonymous Pro B.ttf"

firstDigit, secondDigit = ('%02d' % i).split(//)

values.annotate(bg, 40, 40, 41, 70, firstDigit.to_s) do
	self.pointsize = 89
	self.font = bountyCountFont
	self.font_family = 'Helvetica'
	self.stroke = 'transparent'
	self.fill = '#2F2F2F'
	self.gravity = gravity
end

values.annotate(bg, 40, 40, 134, 70, secondDigit.to_s) do
	self.pointsize = 89
	self.font = bountyCountFont
	self.font_family = 'Helvetica'
	self.stroke = 'transparent'
	self.fill = '#2F2F2F'
	self.gravity = gravity
end

values.annotate(bg, 40, 40, 104, 212, rep.to_s) do
	self.pointsize = 21
	self.font = repFont
	self.stroke = 'transparent'
	self.fill = '#3B3B3B'
	self.gravity = gravity
end

fg.composite!(bg, 35, 105, Magick::OverCompositeOp)

bg.write('./final.png')
