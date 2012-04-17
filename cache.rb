class CacheItem
  attr_reader :value, :time
  
  def initialize(value)
    @time = Time.now()
    @value = value
  end
  
  def to_s()
    "[#@time #@value]"
  end
end
  

class Cache
  def initialize(timeout, &regenerator)
    @timeout = timeout
    @regenerator = regenerator
    @data = {}
  end
  
  def [](key)
    if !@data.member?(key) || (Time.now() - @data[key].time >= @timeout)
      @data[key] = CacheItem.new(@regenerator.call(*key))
    end
    
    @data[key].value
  end
  
  def flush()
    @data = {}
  end
  
  def to_s()
    ret = "===<br/>"
    @data.each do |item|
      ret += "#{item.to_s}<br/>"
    end
    ret + "==="
  end
end

