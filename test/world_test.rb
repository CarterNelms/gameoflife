require 'test_helper'

class WorldTest < MiniTest::Unit::TestCase

  def setup
    # This is ran before all the tests. Useful
    # when preparing input data for the objects/methods you
    # wish to test.
    @world = World.new
  end

  def test_world_start
    assert_equal 0, @world.time
  end

  def test_world_time_passes
    @world.tick
    assert_equal 1, @world.time
  end

  def test_spawn_creates_new_cell
    assert_equal 0, @world.cells.size
    @world.spawn(0, 0)
    assert_equal 1, @world.cells.size
  end

  def test_spawn_creates_inside_world_only
    assert_equal 0, @world.cells.size
    @world.spawn(50, 50)
    assert_equal 0, @world.cells.size    
  end

  def test_spawn_creates_no_duplicates
    assert_equal 0, @world.cells.size
    @world.spawn(0, 0)
    assert_equal 1, @world.cells.size
    @world.spawn(0, 0)
    assert_equal 1, @world.cells.size
  end

  def test_cell_should_live?
    @world.spawn(0, 0)
    @world.spawn(0, 1)
    @world.spawn(1, 0)
    @world.spawn(1, 1)

    assert @world.cell_should_live?(0,0)
    assert @world.cell_should_live?(0,1)
    assert @world.cell_should_live?(1,0)
    assert @world.cell_should_live?(1,1)
    refute @world.cell_should_live?(2,0)
    refute @world.cell_should_live?(2,1)
    refute @world.cell_should_live?(2,2)
    refute @world.cell_should_live?(0,2)
    refute @world.cell_should_live?(1,2)
  end

  def test_tick
    @world.spawn(1,0)
    @world.spawn(1,1)
    @world.spawn(1,2)

    assert @world.cell_exists?(1,0)
    assert @world.cell_exists?(1,1)
    assert @world.cell_exists?(1,2)
    refute @world.cell_exists?(0,1)
    refute @world.cell_exists?(2,1)

    @world.tick

    refute @world.cell_exists?(1,0)
    assert @world.cell_exists?(1,1)
    refute @world.cell_exists?(1,2)
    assert @world.cell_exists?(0,1)
    assert @world.cell_exists?(2,1)

    @world.tick

    assert @world.cell_exists?(1,0)
    assert @world.cell_exists?(1,1)
    assert @world.cell_exists?(1,2)
    refute @world.cell_exists?(0,1)
    refute @world.cell_exists?(2,1)
  end

end
