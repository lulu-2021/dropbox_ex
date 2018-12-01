defmodule DropboxEx.MixProject do
  use Mix.Project

  @description """
    Elixir wrapper for some of the functions on the Dropbox v2 API
  """

  def project do
    [
      app: :dropbox_ex,
      version: "0.1.0",
      elixir: "~> 1.7",
      name: "DropboxEx",
      description: @description,
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :poison, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.0"},
      {:httpoison, "~> 1.4"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp package do
    [maintainers: ["netflakes"],
     licenses: ["MIT"],
     links: %{ "GitHub" => "https://github.com/netflakes/dropbox_ex" }]
  end
end
