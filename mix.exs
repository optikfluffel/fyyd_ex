defmodule FyydEx.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :fyyd_ex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      # dev tools
      {:credo, "~> 0.8", only: :dev, runtime: false},
      {:excoveralls, "~> 0.7", only: :test, runtime: false}
    ]
  end
end
