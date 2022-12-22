defmodule Nyabot.MixProject do
  use Mix.Project

  def project do
    [
      app: :nyabot,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nyabot.Application, []}
    ]
  end

  defp deps do
    [
      {:nostrum, "~> 0.6"},
      {:dotenv_parser, "~> 2.0"}
    ]
  end
end
