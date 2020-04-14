defmodule GameBuilders do
  defmacro __using__(_options) do
    quote do
      alias Life.Game
      import GameBuilders, only: :functions
    end
  end
end

alias Life.Game
