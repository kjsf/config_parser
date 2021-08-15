defmodule ConfigParserTest do
  use ExUnit.Case
  doctest ConfigParser

  test "test parse function" do
    assert ConfigParser.parse("config.ini") ==
             %{
               "debug_mode" => false,
               "host" => "test.com",
               "log_file_path" => "/tmp/logfile.log",
               "send_notifications" => true,
               "server_id" => 55331,
               "server_load_alarm" => 2.5,
               "test_mode" => true,
               "user" => "user",
               "verbose" => true
             }
  end

  test "test get function" do
    assert ConfigParser.get("test_mode", "config.ini") == true
    assert ConfigParser.get("server_load_alarm", "config.ini") == 2.5
    assert ConfigParser.get("server_id", "config.ini") == 55331
    assert ConfigParser.get("host", "config.ini") == "test.com"
  end
end
