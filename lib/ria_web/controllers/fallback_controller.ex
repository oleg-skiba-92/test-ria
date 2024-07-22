defmodule RiaWeb.FallbackController do
  use RiaWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: RiaWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
