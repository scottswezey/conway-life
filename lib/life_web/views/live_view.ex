defmodule LifeWeb.LiveView do
  use LifeWeb, :view

  defp to_s(:live), do: "live"
  defp to_s(:dead), do: "dead"
  defp to_s(_any), do: "huh"
end
