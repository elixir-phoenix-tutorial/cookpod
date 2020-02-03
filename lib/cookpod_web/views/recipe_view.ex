defmodule CookpodWeb.RecipeView do
  use CookpodWeb, :view

  def s3_path(path) do
    s3_config = Application.get_env(:ex_aws, :s3)
    "#{s3_config[:scheme]}#{s3_config[:host]}:#{s3_config[:port]}/cookpod/#{path}"
  end
end
