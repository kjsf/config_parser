defmodule ConfigParserTest do
  use ExUnit.Case
  doctest ConfigParser

  test "greets the world" do
    assert ConfigParser.hello() == :world
  end
end
