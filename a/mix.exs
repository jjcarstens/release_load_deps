defmodule A.MixProject do
  use Mix.Project

  def project do
    [
      app: :a,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [{:a, [applications: [b: :load]]}]
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
      {:b, path: "../b", runtime: false}
    ]
  end
end
