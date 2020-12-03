defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
