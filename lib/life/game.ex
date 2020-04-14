defmodule Life.Game do
  @type t :: %__MODULE__{}
  defstruct board: %{{0, 0} => :dead}, generation: 0, size: 10

  @type pos :: {integer(), integer()}
  @type real_pos :: {pos_integer(), pos_integer()}

  @spec new(integer) :: Life.Game.t()
  def new(size \\ 10) do
    %__MODULE__{
      board: empty_board(size),
      generation: 0,
      size: size
    }
  end

  @spec tick(Life.Game.t()) :: Life.Game.t()
  def tick(game) do
    %__MODULE__{
      game
      | board: tick_board(game),
        generation: game.generation + 1
    }
  end

  @spec toggle_cell(Life.Game.t(), Life.Game.real_pos()) :: Life.Game.t()
  def toggle_cell(game = %{size: s}, {x, y}) when x <= s and y <= s and x >= 0 and y >= 0 do
    %__MODULE__{
      game
      | board: Map.update!(game.board, {x, y}, fn current -> toggle(current) end)
    }
  end

  defp toggle(:dead), do: :live
  defp toggle(:live), do: :dead

  defp tick_board(game) do
    # https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

    # Any live cell with two or three live neighbors survives.
    # Any dead cell with three live neighbors becomes a live cell.
    # All other live cells die in the next generation. Similarly, all other dead cells stay dead.
    Enum.map(game.board, fn {pos, state} ->
      %{live: living} =
        game
        |> neighbors(pos)
        |> count_neighbors

      new_state =
        case {state, living} do
          {:live, 2} -> :live
          {:live, 3} -> :live
          {:dead, 3} -> :live
          _ -> :dead
        end

      {pos, new_state}
    end)
    |> Map.new()
  end

  def neighbors(game = %{size: s}, {x, y})
      when x <= s and y <= s and x > 0 and y > 0 do
    Enum.flat_map(-1..1, fn a ->
      Enum.map(-1..1, fn b ->
        case {a, b} do
          {0, 0} ->
            :self

          _ ->
            get_cell(game, {x + a, y + b})
        end
      end)
    end)
  end

  def wrap_cell(_game = %{size: s}, {a, b}) do
    x = wrap_index(1, s, a)
    y = wrap_index(1, s, b)

    {x, y}
  end

  defp wrap_index(min, max, index) do
    toobig = max + 1
    toosmall = min - 1

    case index do
      ^toobig -> min
      ^toosmall -> max
      _ -> index
    end
  end

  def count_neighbors(neighbors) do
    Map.merge(
      %{dead: 0, live: 0, self: 0},
      Enum.frequencies(neighbors)
    )
  end

  defp get_cell(game, {x, y}) do
    Map.get(game.board, wrap_cell(game, {x, y}))
  end

  defp empty_board(size) when is_integer(size) and size > 3 do
    Enum.flat_map(1..size, fn x ->
      Enum.flat_map(1..size, fn y ->
        %{{x, y} => :dead}
      end)
    end)
    |> Map.new()
  end
end
