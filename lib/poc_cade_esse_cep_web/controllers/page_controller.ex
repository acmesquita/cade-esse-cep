defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"page" => %{ "zip" => zip}}) do

    render(conn, "result.html", zip: zip)
  end
end
