defmodule LiveSelectDebugWeb.PageController do
  use LiveSelectDebugWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
