defmodule RawResize.Sips do

  def pixel_width do
    1500
  end

  def quality do
    "80%"
  end

  def args(input, output) do
    ["-s", "format", "jpeg",
     "-s", "formatOptions", "#{quality}",
     "-Z", "#{pixel_width}",
     input,
     "--out", output]
  end


  def run(input, output) do
    %Porcelain.Result{out: resize_output, status: resize_status} = Porcelain.exec("sips", args(input, output))
    output_file_exists = File.exists?(output)
    {:ok, file_stat} = File.stat output

    %{output: resize_output, status: resize_status, file_exists: output_file_exists, file_stat: file_stat}
  end

  def resize(input, output) do
    if String.equivalent?(input, output) do
      {:error, :same_filename}
    else
      {:ok, run(input, output)}
    end

  end

end
