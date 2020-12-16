defmodule LifeWeb.GameLive do
  use LifeWeb, :live_view

  @initial_size 20
  @initial_delay 500
  @min_delay 100

  # @impl true
  # def render(assigns) do
  #   Phoenix.View.render(LifeWeb.LiveView, "game.html", assigns)
  # end

  @impl true
  def mount(_params, _, socket) do
    {:ok,
     assign(socket,
       game: Life.Game.new(@initial_size),
       game_active: false,
       timer: nil,
       size: @initial_size,
       delay: @initial_delay
     )}
  end

  @impl true
  def handle_info(:tick, socket) do
    new_state = Life.Game.tick(socket.assigns.game)
    {:noreply, assign(socket, game: new_state)}
  end

  @impl true
  def handle_event("toggle", %{"x" => x, "y" => y}, socket) do
    pos = {String.to_integer(x), String.to_integer(y)}
    new_game = socket.assigns.game |> Life.Game.toggle_cell(pos)

    {:noreply, assign(socket, game: new_game)}
  end

  @impl true
  def handle_event("start", _value, socket) do
    {:ok, timer} = :timer.send_interval(socket.assigns.delay, self(), :tick)
    {:noreply, assign(socket, game_active: true, timer: timer)}
  end

  @impl true
  def handle_event("step", _value, socket) do
    {:noreply, assign(socket, game: Life.Game.tick(socket.assigns.game))}
  end

  @impl true
  def handle_event("pause", _value, socket) do
    :timer.cancel(socket.assigns.timer)
    {:noreply, assign(socket, game_active: false, timer: nil)}
  end

  @impl true
  def handle_event("set-size", %{"value" => size}, socket) do
    timer = socket.assigns.timer

    if timer != nil do
      :timer.cancel(timer)
    end

    size = String.to_integer(size)

    {:noreply,
     assign(socket, game_active: false, game: Life.Game.new(size), size: size, timer: nil)}
  end

  @impl true
  def handle_event("set-delay", %{"value" => delay}, socket) do
    delay =
      delay
      |> String.to_integer()
      |> List.wrap()
      |> Kernel.++([@min_delay])
      |> Enum.max()

    timer = socket.assigns.timer

    if timer != nil do
      :timer.cancel(timer)
    end

    {:ok, timer} =
      case socket.assigns.game_active do
        true -> :timer.send_interval(delay, self(), :tick)
        false -> {:ok, nil}
      end

    {:noreply, assign(socket, delay: delay, timer: timer)}
  end

  @impl true
  def handle_event("reset", _value, socket) do
    timer = socket.assigns.timer

    if timer != nil do
      :timer.cancel(timer)
    end

    {:noreply, assign(socket, game_active: false, game: Life.Game.new(socket.assigns.size))}
  end

  defp to_s(:live), do: "live"
  defp to_s(:dead), do: "dead"

  # This should not be possible
  defp to_s(_any), do: "huh"
end
