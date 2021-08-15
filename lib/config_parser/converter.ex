defmodule ConfigParser.Converter do
  def convert("true"), do: true

  def convert("false"), do: false

  def convert(value) do
    try do
      try do
        String.to_integer(value)
      rescue
        ArgumentError -> String.to_float(value)
      end
    rescue
      _ -> value
    end
  end
end
