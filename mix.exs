defmodule KeyTools.Mixfile do
  use Mix.Project

  def project do
    [
      app: :key_tools,
      description: "Simple functions for coercing Elixir Maps: atomizing, snake_casing, etc.",
      source_url: "https://github.com/EthanML/key_tools_ex",
      version: "0.3.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.12", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Ethan Lowry"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/EthanML/key_tools_ex"
      }
    ]
  end
end
