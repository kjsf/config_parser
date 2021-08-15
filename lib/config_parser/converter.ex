defmodule ConfigParser.Converter do
  def convert(value) when value in ["true", "on", "yes"], do: true

  def convert(value) when value in ["false", "off", "no"], do: false

  def convert(value) do
    try do
      try do
        String.to_integer(value)
      rescue
        ArgumentError -> String.to_float(value)
      end
    rescue
      ArgumentError -> value
    end
  end
end
