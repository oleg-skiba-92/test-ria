defmodule RiaWeb.ApiPostController do
  use RiaWeb, :controller

  alias Ria.Blog

  action_fallback RiaWeb.FallbackController

  def list(conn, _params) do
    posts = Blog.list_posts()
    render(conn, :list, posts: posts)
  end

  def getById(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, :one, post: post)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, post} <- Blog.create_post(post_params) do
      render(conn, :one, post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, post} <- Blog.update_post(post, post_params) do
      render(conn, :one, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    with {:ok, _post} = Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
