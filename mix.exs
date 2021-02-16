defmodule Playground.MixProject do
  use Mix.Project

  def project do
    [
      app: :playground,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Playground.Application, []}
    ]
  end

  defp deps do
    [
      {:faker, "~> 0.16.0"},
      {:flow, "~> 1.1"},
      {:gen_stage, "~> 1.1"}
    ]
  end
end
