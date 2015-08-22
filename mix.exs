defmodule JwtClaims.Mixfile do
  use Mix.Project

  def project do
    [
      app: :jwt_claims,
      version: "0.0.1",
      elixir: "~> 1.0.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package,
      description: "Elixir implementation of JSON Web Token (JWT) registered claims, RFC 7519",
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:excoveralls, "~> 0.3", only: :test}
    ]
  end

  defp package do
    [
      contributors: ["Gary Fleshman"],
      licenses: ["MIT"],
    ]
  end
end
