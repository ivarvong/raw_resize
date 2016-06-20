defmodule RawResize.Mixfile do
  use Mix.Project

  def project do
    [app: :raw_resize,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end


  def application do
    [applications: [:logger, :porcelain],
     mod: {RawResize, []}]
  end

  defp deps do
    [{:porcelain, "~> 2.0"}]
  end
end
