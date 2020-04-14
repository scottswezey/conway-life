defmodule LifeWeb.GameLive do
  use Phoenix.LiveView

  @size 20
  @delay 200

  # defstruct game: nil, game_active: false, timer: nil, size: 10

  def render(assigns) do
    Phoenix.View.render(LifeWeb.LiveView, "game.html", assigns)
  end

  def mount(_params, _, socket) do
    {:ok,
     assign(socket, game: Life.Game.new(@size), game_active: false, timer: nil, delay: @delay)}
  end

  # defp new(size \\ 10) do
  #   %__MODULE__{size: size, game: Life.Game.new(size)}
  # end

  def handle_info(:tick, socket) do
    new_state = Life.Game.tick(socket.assigns.game)
    {:noreply, assign(socket, game: new_state)}
  end

  def handle_event("toggle", %{"x" => x, "y" => y}, socket) do
    pos = {String.to_integer(x), String.to_integer(y)}
    new_game = socket.assigns.game |> Life.Game.toggle_cell(pos)

    {:noreply, assign(socket, game: new_game)}
  end

  def handle_event("start", _value, socket) do
    {:ok, timer} = :timer.send_interval(socket.assigns.delay, self(), :tick)
    {:noreply, assign(socket, game_active: true, timer: timer)}
  end

  def handle_event("step", _value, socket) do
    {:noreply, assign(socket, game: Life.Game.tick(socket.assigns.game))}
  end

  def handle_event("pause", _value, socket) do
    :timer.cancel(socket.assigns.timer)
    {:noreply, assign(socket, game_active: false, timer: nil)}
  end

  def handle_event("set-delay", %{"value" => delay}, socket) do
    :timer.cancel(socket.assigns.timer)
    delay = String.to_integer(delay)

    {:noreply, assign(socket, delay: delay, timer: nil, game_active: false)}
  end

  def handle_event("reset", _value, socket) do
    timer = socket.assigns.timer

    if timer != nil do
      :timer.cancel(timer)
    end

    {:noreply, assign(socket, game_active: false, game: Life.Game.new(@size))}
  end
end
