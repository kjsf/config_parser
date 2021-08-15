defmodule ConfigParser do
  @moduledoc """
  Parses configuration files located in the priv directory.
  """

  @priv_path Path.expand("../priv", __DIR__)

  alias ConfigParser.TypeConverter

  @doc """
  Parses given `config_file` from the priv directory.
  """

  @spec parse(String.t()) :: %{}
  def parse(config_file) do
    read_file(config_file)
    |> clean_up()
    |> convert_to_map()
  end

  @doc """
  Returns the value of the given `setting` in the `config_file`.

  ## Examples

    iex> ConfigParser.get("server_id", "config.ini")
    55331

  """

  @spec get(String.t(), String.t()) :: any()
  def get(setting, config_file) do
    config_map = parse(config_file)
    config_map[setting]
  end

  @spec read_file(String.t()) :: String.t()
  defp read_file(file_name) do
    path = Path.join(@priv_path, file_name)
    {:ok, binary} = File.read(path)
    binary
  end

  @spec clean_up(String.t()) :: [String.t()]
  defp clean_up(string) do
    string
    |> String.replace(~r/ |^#.*/m, "")
    |> String.split("\n", trim: true)
  end

  @spec convert_to_map([String.t()]) :: %{}
  defp convert_to_map(list) do
    for key_value <- list, reduce: %{} do
      acc ->
        [key | value] = String.split(key_value, "=")
        true_value = TypeConverter.convert(List.to_string(value))
        Map.put(acc, key, true_value)
    end
  end
end
