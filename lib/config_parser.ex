defmodule ConfigParser do
  @moduledoc """
  Parses configuration files located in the priv directory.
  """

  @priv_path Path.expand("../priv", __DIR__)

  alias ConfigParser.TypeConverter

  @doc """
  Parses given `config_file` from the priv directory.
  """

  @spec parse(String.t()) :: map()
  def parse(config_file) do
    read_file(config_file)
    |> remove_comments()
    |> split_by_newline()
    |> transform_to_map()
  end

  @doc """
  Returns the value of the given config `parameter` from the given config `file`.

  ## Examples

    iex> ConfigParser.get("server_id", "config.ini")
    55331

  """

  @spec get(String.t(), String.t()) :: any()
  def get(parameter, file) do
    config_map = parse(file)
    config_map[parameter]
  end

  @spec read_file(String.t()) :: String.t()
  defp read_file(file_name) do
    file_path = Path.join(@priv_path, file_name)
    {:ok, binary} = File.read(file_path)
    binary
  end

  @spec remove_comments(String.t()) :: String.t()
  defp remove_comments(string) do
    String.replace(string, ~r/ |^#.*/m, "")
  end

  @spec split_by_newline(String.t()) :: [String.t()]
  defp split_by_newline(string) do
    String.split(string, "\n", trim: true)
  end

  @spec transform_to_map([String.t()]) :: map()
  defp transform_to_map(list) do
    for key_value <- list, reduce: %{} do
      acc ->
        [key | [value]] = String.split(key_value, "=")

        Map.put(acc, key, TypeConverter.convert(value))
    end
  end
end
