defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", error: "")
  end

  def show(conn, %{"page" => %{ "zip" => zip}}) do
    address = PocCadeEsseCepWeb.FindCepService.findAddress(zip)

    {status, result} = address

    if status != :error  do
      addressNormalize = PocCadeEsseCepWeb.Normalize.normalizeAddress(result)

      latLon =  result
        |> PocCadeEsseCepWeb.Normalize.normalizeAddressForSearch
        |> PocCadeEsseCepWeb.FindCepService.findLatLongFromAddress

      render(conn, "result.html", result: addressNormalize, lat: latLon.lat, lon: latLon.lon, zip: zip)
    else
      render(conn, "index.html", error: result, zip: zip)
    end
  end
end
