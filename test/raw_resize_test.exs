defmodule RawResizeTest do
  use ExUnit.Case
  doctest RawResize

  # test "arg list generation" do
  #   expected = ["-s", "format", "jpeg", "\"in\"", "--out", "\"out\""]
  #   assert RawResize.Sips.args("in", "out") == expected
  # end

  def random_string do
    length = 10
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  test "a resize" do
    input  = Path.expand("./data/beach.cr2", __DIR__)
    output = Path.expand("./data/beach-#{random_string}.jpg", __DIR__)

    {:ok, result} = RawResize.Sips.resize(input, output)
    IO.inspect result

    assert result.file_stat.size >  50_000
    assert result.file_stat.size < 300_000
    assert result.status == 0
    assert File.exists?(output)
  end

  test "wont allow same output name as input" do
    result = RawResize.Sips.resize("a", "a")
    assert result == {:error, :same_filename}
  end


end
