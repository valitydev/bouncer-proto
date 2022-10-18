defmodule BouncerProto.MixProject do
  use Mix.Project

  def project do
    [
      app: :bouncer_proto,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:thrift, :woody | Mix.compilers],
      thrift: [
        files: Path.wildcard("proto/*.thrift")
      ]
    ]
  end

  def application, do: []

  defp deps do
    [
      {:thrift, git: "https://github.com/pinterest/elixir-thrift", branch: "master"},
      {:woody_ex, git: "https://github.com/valitydev/woody_ex.git", branch: "ft/thrift-elixir"}
    ]
  end
end
