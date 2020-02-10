defmodule Cookpod.Recipes.Picture do
  def upload!(plug_upload) do
    ext = Path.extname(plug_upload.filename)
    upload!(plug_upload.path, ext, plug_upload.content_type)
  end

  def upload!(path, ext, content_type) do
    content = File.read!(path)
    digest = Base.encode16(:erlang.md5(content), case: :lower)
    file_name = "#{digest}#{ext}"
    object = "recipes/pictures/#{file_name}"

    bucket()
    |> ExAws.S3.put_object(object, content, [content_type: content_type])
    |> ExAws.request!

    object
  end

  def resize(recipe, on_finish) do
    Task.async(fn ->
      Process.sleep(5_000)
      on_finish.()
    end)
    recipe
  end

  defp bucket(), do: Application.get_env(:cookpod, :s3_bucket, "cookpod")
end
