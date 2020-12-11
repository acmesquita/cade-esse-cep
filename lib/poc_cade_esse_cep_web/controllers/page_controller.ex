defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", error: "")
  end

  def show(conn, %{"page"=>%{"zip"=>zip}}) do
    address = PocCadeEsseCepWeb.FindCepService.find_address(zip)

    {status, result} = address

    if status != :error  do
      address_normalize = PocCadeEsseCepWeb.Normalize.normalize_address(result)

      lat_lon =  result
        |> PocCadeEsseCepWeb.Normalize.normalize_address_for_search
        |> PocCadeEsseCepWeb.FindCepService.find_lat_long_from_address

      render(conn, "result.html", result: address_normalize, lat: lat_lon.lat, lon: lat_lon.lon, zip: zip)
    else
      render(conn, "index.html", error: result, zip: zip)
    end
  end
end
