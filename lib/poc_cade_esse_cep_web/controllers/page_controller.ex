defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  alias PocCadeEsseCep.{FindCepService, Normalize}

  def index(conn, _params) do
    render(conn, "index.html", error: "")
  end

  def show(conn, %{"page"=>%{"zip"=>zip}}) do
    address = PocCadeEsseCep.find_zip_code(zip)

    {status, result} = address

    if status != :error  do
      address_normalize = Normalize.normalize_address(result)

      lat_lon =  result
        |> Normalize.normalize_address_for_search
        |> FindCepService.find_lat_long_from_address

      render(conn, "result.html", result: address_normalize, lat: lat_lon.lat, lon: lat_lon.lon, zip: zip)
    else
      render(conn, "index.html", error: result, zip: zip)
    end
  end
end
