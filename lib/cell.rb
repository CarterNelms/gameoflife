class Cell

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def neighbors?(x, y)
    distance = Math.sqrt((y-@y).abs**2 + (x-@x).abs**2).floor
    return distance == 1
  end

end
