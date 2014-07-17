require 'test_helper'

class CellTest < MiniTest::Unit::TestCase

  def setup
    # This is ran before all the tests. Useful
    # when preparing input data for the objects/methods you
    # wish to test.
    @cell = Cell.new(4, 4)
  end

  def test_create_cell
    assert_respond_to @cell, :x
    assert_respond_to @cell, :y
    assert_equal 4, @cell.x
    assert_equal 4, @cell.y
  end

  def test_are_neighbors
    assert @cell.neighbors?(4, 3)
    assert @cell.neighbors?(5, 5)
  end

  def test_are_not_neighbors
    assert !@cell.neighbors?(4, 4)
    assert !@cell.neighbors?(6, 4)
  end

end
