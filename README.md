# KeyTools

Simple functions for coercing Elixir Maps (or Lists of Maps).

## Usage

Say your API provides you with camelCased string keys...

```elixir
iex(1)> payload = %{
...(1)>   "data" => [
...(1)>     %{
...(1)>       "userName" => "EthanML"
...(1)>     }
...(1)>   ]
...(1)> }
```

...and you want them to conform to Elixir standards, i.e. have atoms for keys and use snake_casing:

```elixir
iex(2)> import KeyTools
iex(3)> payload
...(3)> |> atomize_keys
...(3)> |> underscore_keys
%{data: [%{user_name: "EthanML"}]}
```

And that's about it.

Note that this library uses and thus is bound by the same limitations detailed in the docs for `Macro.underscore/1`:

> This function was designed to underscore language identifiers/tokens, that's
> why it belongs to the Macro module. Do not use it as a general mechanism for
> underscoring strings as it does not support Unicode or characters that are 
> not valid in Elixir identifiers.

...so be careful if you're likely to have to deal with any unusual characters in your keys.

## Installation

How to install from [Hex](https://hex.pm/packages/key_tools):

  1. Add `key_tools` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:key_tools, "~> 0.1.0"}]
    end
    ```

  2. Ensure `key_tools` is started before your application:

    ```elixir
    def application do
      [applications: [:key_tools]]
    end
    ```

