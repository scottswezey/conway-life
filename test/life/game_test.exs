defmodule Life.GameTest do
  use ExUnit.Case
  use GameBuilders

  test "Valid board positions dont wrap around" do
    game = Game.new(2)
    assert Game.wrap_cell(game, {1, 1}) == {1, 1}
    assert Game.wrap_cell(game, {1, 2}) == {1, 2}
    assert Game.wrap_cell(game, {2, 1}) == {2, 1}
    assert Game.wrap_cell(game, {2, 2}) == {2, 2}
  end

  test "Board position indexes wrap around" do
    game = Game.new(2)
    assert Game.wrap_cell(game, {0, 0}) == {2, 2}
    assert Game.wrap_cell(game, {1, 3}) == {1, 1}
    assert Game.wrap_cell(game, {3, 2}) == {1, 2}
    assert Game.wrap_cell(game, {3, 3}) == {1, 1}
  end
end
