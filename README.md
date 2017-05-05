# EventCast


## Usage (WIP)

start the server
```shell
  elixir --sname event_cast -S mix run --no-halt
```

```shell
  iex --sname client
```

replace <server_host> with actual value
```elixir
 Node.connect :"event_cast@<server_host>"
 Node.spawn(:"event_cast@<server_host>", fn -> Client.echo "hello" end)
```

### Within IEX

```elixir
  Client.reverse "Hello World"
```

```elixir
  msg = %EventCast.Message{context: :base, action: :reverse, payload: "Hello World"}
  EventCast.MessageDispatcher.process(msg)
```

```elixir
  event = %Event{arguments: "Hello World", function: &(String.reverse(&1))}
  EventCast.Queue.enqueue(event)
  EventCast.Queue.next
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `event_cast` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:event_cast, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/event_cast](https://hexdocs.pm/event_cast).
