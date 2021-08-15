defmodule ConfigParser do
  @moduledoc """
  Documentation for `ConfigParser`.
  """

  @priv_path Path.expand("../priv", __DIR__)

  alias ConfigParser.Converter

  def get_config(file_name) do
    path = Path.join(@priv_path, file_name) |> IO.inspect()
    {:ok, binary} = File.read(path)

    config_list =
      binary
      |> String.replace(~r/ |^#.*/m, "")
      |> String.split("\n", trim: true)

    for key_value <- config_list, reduce: %{} do
      acc ->
        [key | value] = String.split(key_value, "=")
        converted_value = Converter.convert(List.to_string(value))
        Map.put(acc, key, converted_value)
    end
  end
end
