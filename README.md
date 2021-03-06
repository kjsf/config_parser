# ConfigParser

**Wanted to solve a coding challenge I found online using elixir.**

### Instructions:

1. Do not use existing "complete" configuration parsing libraries/functions, we want to see how you would write the code to do this.
2. Use of core and stdlib functions/objects such as string manipulation, regular expressions, etc is ok.
3. We should be able to get the values of the config parameters in code, via their name. How this is done specifically is up to you.
4. Boolean-like config values (on/off, yes/no, true/false) should return real booleans: true/false.
5. Numeric config values should return real numerics: integers, doubles, etc.
6. Ignore or error out on invalid config lines, your choice.
7. Please include a short example usage of your code so we can see how you call it/etc.

### Valid config file:

```
# This is what a comment looks like, ignore it

# All these config lines are valid

host = test.com

server_id=55331

server_load_alarm=2.5

user= user

# comment can appear here as well

verbose =true

test_mode = on

debug_mode = off

log_file_path = /tmp/logfile.log

send_notifications = yes
```

### Code Usage:

This app parses the given config file from the _priv directory_.

#### Clone the repo and run this on the command line
```bash
  iex -S mix
```

#### Parsing a config file
```elixir
  iex> ConfigParser.parse("config.ini")
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
```

#### Retrieving a specific config parameter value
```elixir
  iex> ConfigParser.get("server_id", "config.ini")
  55331
```
