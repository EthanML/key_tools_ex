defmodule KeyTools do
  @moduledoc """
  Provides common functions for coercing a `Map` or `List`.
  """

  @doc """
  Deeply converts all string keys within the given `Map` or `List` to atoms.

  ## Examples

  iex(1)> KeyTools.atomize_keys %{"data" => ["Hello", "World!"]}
  %{data: ["Hello", "World!"]}

  iex(2)> KeyTools.atomize_keys [%{"nested_data" => %{"deep" => :stuff}}]
  [%{nested_data: %{deep: :stuff}}]
  """
  def atomize_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{}, do: {String.to_atom(key), atomize_keys(value)}
  end

  def atomize_keys(list) when is_list(list), do: Enum.map list, &atomize_keys/1
  def atomize_keys(anything), do: anything

  @doc """
  Deeply converts all camelCased keys within the given `Map` or `List` to snake_case.

  Affects only keys; values will remain unchanged. Works on string and atom keys.

  The same limitations detailed in the docs for `Macro.underscore` apply here,
  so be careful if there is potential for non-standard characters within your keys.

  ## Examples

  iex(1)> KeyTools.underscore_keys %{"scumbagKey" => "is a camel"}
  %{"scumbag_key" => "is a camel"}

  iex(2)> KeyTools.underscore_keys [%{"nestedKeys" => %{"greatSuccess" => ":)"}}]
  [%{"nested_keys" => %{"great_success" => ":)"}}]
  """
  def underscore_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{} do
      if is_binary(key) do
        {Macro.underscore(key), underscore_keys(value)}
      else
        {underscore_keys(key), underscore_keys(value)}
      end
    end
  end

  def underscore_keys(atom) when is_atom(atom) do
    atom
    |> Atom.to_string
    |> Macro.underscore
    |> String.to_atom
  end

  def underscore_keys(list) when is_list(list), do: Enum.map list, &underscore_keys/1
  def underscore_keys(anything), do: anything

  @doc """
  Deeply converts all snake_cased keys within the given `Map` or `List` to camelCase.

  Affects only keys; values will remain unchanged. Works on string and atom keys.

  The same limitations detailed in the docs for `Macro.camelize` apply here,
  so be careful if there is potential for non-standard characters within your keys.

  ## Examples

  iex(1)> KeyTools.camelize_keys %{"snake_key" => "is a snake"}
  %{"SnakeKey" => "is a snake"}

  iex(2)> KeyTools.camelize_keys [%{"nested_keys" => %{"great_success" => ":)"}}]
  [%{"NestedKeys" => %{"GreatSuccess" => ":)"}}]
  """
  def camelize_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{} do
      if is_binary(key) do
        {Macro.camelize(key), camelize_keys(value)}
      else
        {camelize_keys(key), camelize_keys(value)}
      end
    end
  end

  def camelize_keys(atom) when is_atom(atom) do
    atom
    |> Atom.to_string
    |> Macro.camelize
    |> String.to_atom
  end

  def camelize_keys(list) when is_list(list), do: Enum.map list, &camelize_keys/1
  def camelize_keys(anything), do: anything

  @doc """
  Deeply converts all keys within the given `Map` or `List` to strings.

  ## Examples

  iex(1)> stringify_keys %{atom_key: :atom_value}
  %{"atom_key" => :atom_value}

  iex(2)> stringify_keys [%{atom_key: %{42 => [%{another_key: 23}]}}]
  [%{"atom_key" => %{"42" => [%{"another_key" => 23}]}}]
  """
  def stringify_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{}, do: {to_string(key), stringify_keys(value)}
  end

  def stringify_keys(list) when is_list(list), do: Enum.map list, &stringify_keys/1
  def stringify_keys(anything), do: anything
end
