defmodule Life.GameTest do
  use ExUnit.Case
  use GameBuilders

  test "Valid board positions dont wrap around" do
    game = Game.new(4)
    assert Game.wrap_cell(game, {1, 1}) == {1, 1}
    assert Game.wrap_cell(game, {1, 4}) == {1, 4}
    assert Game.wrap_cell(game, {4, 1}) == {4, 1}
    assert Game.wrap_cell(game, {4, 4}) == {4, 4}
  end

  test "Board position indexes wrap around" do
    game = Game.new(4)
    assert Game.wrap_cell(game, {0, 0}) == {4, 4}
    assert Game.wrap_cell(game, {1, 5}) == {1, 1}
    assert Game.wrap_cell(game, {5, 2}) == {1, 2}
    assert Game.wrap_cell(game, {5, 5}) == {1, 1}
  end
end
