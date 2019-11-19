defmodule Pubbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :pubbot,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex, :hackney],
      mod: {Pubbot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: [:dev, :test]},
      {:credo, "~> 1.1", only: [:dev, :test]},
      {:excoveralls, "~> 0.12", only: [:dev, :test]},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.6"},
      {:amqp, "~>1.3"},
      {:jason, "~> 1.1"},
      {:uuid, "~> 1.1"}
    ]
  end
end
