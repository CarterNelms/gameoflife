class World

  attr_reader :time, :width, :height, :cells, :cells_next

  def initialize(length=50)
    @time = 0
    @cells = []
    @cells_next = []
    @width = length
    @height = length
  end

  def tick
    @time += 1
    @cells_next = []
    for y in 0...@height
      for x in 0...@width
        @cells_next.push(Cell.new(x, y)) if self.cell_should_live?(x, y)
      end
    end
    @cells = @cells_next
  end

  def cell_should_live?(x,y)
    is_cell_alive = self.find_cell(x,y).size > 0

    num_of_live_neighbors = @cells.select{|cell|
      is_x_in_range = cell.x >= x-1 && cell.x <= x+1
      is_y_in_range = cell.y >= y-1 && cell.y <= y+1
      is_same_cell = cell.x == x && cell.y == y
      is_x_in_range && is_y_in_range && !is_same_cell
    }.size

    return is_cell_alive ?
      num_of_live_neighbors >= 2 && num_of_live_neighbors <= 3 :
        num_of_live_neighbors == 3
  end

  def spawn(x,y)
    does_cell_exist = self.find_cell(x,y).size > 0
    is_x_valid = x >=0 && x < @width
    is_y_valid = y >=0 && y < @height
    @cells.push(Cell.new(x,y)) if is_x_valid && is_y_valid && !does_cell_exist
  end

  def find_cell(x,y)
    @cells.select{|cell| cell.x == x && cell.y == y}
  end

  def cell_exists?(x,y)
    return find_cell(x,y).size > 0
  end

end
