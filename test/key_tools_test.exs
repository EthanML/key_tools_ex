defmodule KeyToolsTest do
  use ExUnit.Case, async: true
  import KeyTools, only: [atomize_keys: 1,
                          underscore_keys: 1]
  doctest KeyTools

  describe "Payload.atomize_keys/1" do
    test "converts a map's string keys to atoms" do
      string_keys = %{"a" => 1, "b" => 2}
      atom_keys = %{a: 1, b: 2}
      assert atomize_keys(string_keys) == atom_keys
    end

    test "atomizes keys in nested maps" do
      string_keys = %{"a" => 1, "b" => %{"c" => 3}}
      atom_keys = %{a: 1, b: %{c: 3}}
      assert atomize_keys(string_keys) == atom_keys
    end

    test "atomizes maps inside a list" do
      string_keys = %{"a" => "string", "b" => [%{"c" => 3}]}
      atom_keys = %{a: "string", b: [%{c: 3}]}
      assert atomize_keys(string_keys) == atom_keys
    end

    test "returns other input types unchanged" do
      assert atomize_keys("string") == "string"
    end
  end

  describe "Payload.underscore_keys/1" do
    test "converts a map's string keys to snake case" do
      camel_keys = %{"camelKeyOne" => "String val", "camelKeyTwo" => 2}
      snake_keys = %{"camel_key_one" => "String val", "camel_key_two" => 2}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snake cases keys in nested maps" do
      camel_keys = %{"camelKeyOne" => 1, "camelKeyTwo" => %{"camelKeyThree" => 3}}
      snake_keys = %{"camel_key_one" => 1, "camel_key_two" => %{"camel_key_three" => 3}}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snake cases maps inside a list" do
      camel_keys = %{"camelKeyOne" => 1, "camelKeyTwo" => [%{"camelKeyThree" => 3}]}
      snake_keys = %{"camel_key_one" => 1, "camel_key_two" => [%{"camel_key_three" => 3}]}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snakes cases atom keys" do
      camel_keys = %{camelKeyOne: 1, camelKeyTwo: 2}
      snake_keys = %{camel_key_one: 1, camel_key_two: 2}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "returns other input types unchanged" do
      assert underscore_keys("camel_string") == "camel_string"
    end
  end

end
