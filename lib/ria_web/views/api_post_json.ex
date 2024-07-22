defmodule RiaWeb.ApiPostJSON do
  alias Ria.Blog.Post

  def list(%{posts: posts}) do
    for(post <- posts, do: mapFull(post))
  end

  def one(%{post: post}) do
    mapFull(post)
  end


  defp mapFull(%Post{} = post) do
    post
      |> Map.from_struct()
      |> Map.take([:id, :title, :body, :inserted_at, :updated_at])
  end
end
