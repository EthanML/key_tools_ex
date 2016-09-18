defmodule KeyToolsTest do
  use ExUnit.Case, async: true
  import KeyTools
  doctest KeyTools

  describe "KeyTools.atomize_keys/1" do
    test "atomizes a map's string keys" do
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

  describe "KeyTools.underscore_keys/1" do
    test "converts a map's string keys to snake_case" do
      camel_keys = %{"camelKeyOne" => "String val", "camelKeyTwo" => 2}
      snake_keys = %{"camel_key_one" => "String val", "camel_key_two" => 2}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snake_cases keys in nested maps" do
      camel_keys = %{"camelKeyOne" => 1, "camelKeyTwo" => %{"camelKeyThree" => 3}}
      snake_keys = %{"camel_key_one" => 1, "camel_key_two" => %{"camel_key_three" => 3}}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snake_cases maps inside a list" do
      camel_keys = %{"camelKeyOne" => 1, "camelKeyTwo" => [%{"camelKeyThree" => 3}]}
      snake_keys = %{"camel_key_one" => 1, "camel_key_two" => [%{"camel_key_three" => 3}]}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "snakes_cases atom keys" do
      camel_keys = %{camelKeyOne: 1, camelKeyTwo: 2}
      snake_keys = %{camel_key_one: 1, camel_key_two: 2}
      assert underscore_keys(camel_keys) == snake_keys
    end

    test "returns other input types unchanged" do
      assert underscore_keys("camelString") == "camelString"
    end
  end

  describe "KeyTools.camelize_keys/1" do
    test "converts a map's string keys to CamelCase" do
      snake_keys = %{"snake_key_one" => "String val", "snake_key_two" => 2}
      camel_keys = %{"SnakeKeyOne" => "String val", "SnakeKeyTwo" => 2}
      assert camelize_keys(snake_keys) == camel_keys
    end

    test "camelizes keys in nested maps" do
      snake_keys = %{"snake_key_one" => 1, "snake_key_two" => %{"snake_key_three" => 3}}
      camel_keys = %{"SnakeKeyOne" => 1, "SnakeKeyTwo" => %{"SnakeKeyThree" => 3}}
      assert camelize_keys(snake_keys) == camel_keys
    end

    test "camelizes maps inside a list" do
      snake_keys = %{"snake_key_one" => 1, "snake_key_two" => [%{"snake_key_three" => 3}]}
      camel_keys = %{"SnakeKeyOne" => 1, "SnakeKeyTwo" => [%{"SnakeKeyThree" => 3}]}
      assert camelize_keys(snake_keys) == camel_keys
    end

    test "camelizes cases atom keys" do
      snake_keys = %{snake_key_one: 1, snake_key_two: 2}
      camel_keys = %{SnakeKeyOne: 1, SnakeKeyTwo: 2}
      assert camelize_keys(snake_keys) == camel_keys
    end

    test "returns other input types unchanged" do
      assert camelize_keys("snake_string") == "snake_string"
    end
  end

  describe "KeyTools.stringify_keys/1" do
    test "stringifies atom keys" do
      atom_keys = %{atom_key: :not_a_string}
      string_keys = %{"atom_key" => :not_a_string}
      assert KeyTools.stringify_keys(atom_keys) == string_keys
    end

    test "stringifies number keys" do
      number_keys = %{42 => :not_a_string}
      string_keys = %{"42" => :not_a_string}
      assert KeyTools.stringify_keys(number_keys) == string_keys
    end

    test "stringifies keys in nested maps" do
      nested_keys = %{atom_key: %{69 => 71}}
      nested_string_keys = %{"atom_key" => %{"69" => 71}}
      assert KeyTools.stringify_keys(nested_keys) == nested_string_keys
    end

    test "stringifies maps inside a list" do
      list_keys = [%{atom_key: %{another_one: [%{deeper: :still}]}}]
      string_list_keys = [%{"atom_key" => %{"another_one" => [%{"deeper" => :still}]}}]
      assert KeyTools.stringify_keys(list_keys) == string_list_keys
    end

    test "does nothing with empty collections" do
      assert stringify_keys([]) == []
      assert stringify_keys(%{}) == %{}
    end

    test "returns other input types unchanged" do
      assert stringify_keys(:atom) == :atom
      assert stringify_keys(42) == 42
      assert stringify_keys("string") == "string"
    end
  end
end
