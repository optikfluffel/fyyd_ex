defmodule FyydEx.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :fyyd_ex,
      version: "0.2.4",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      source_url: "https://github.com/optikfluffel/fyyd_ex",
      description: "A basic wrapper for the Fyyd API.",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.1"},
      # dev tools
      {:mix_test_watch, "~> 0.9", only: :dev, runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      # test tools
      {:timex, "~> 3.5", only: :test},
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
      {:stream_data, "~> 0.4", only: :test},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp package() do
    [
      maintainers: ["optikfluffel"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/optikfluffel/fyyd_ex"}
    ]
  end
end
