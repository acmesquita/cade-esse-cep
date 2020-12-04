defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", result: "")
  end

  def show(conn, %{"page" => %{ "zip" => zip}}) do
    address = zip 
      |> PocCadeEsseCepWeb.Normalize.normalizeZipCode
      |> PocCadeEsseCepWeb.FindCepService.validateSizeZipCode
      |> PocCadeEsseCepWeb.FindCepService.sendCEP

    result = address
      |> PocCadeEsseCepWeb.Normalize.normalizeAddress
      
    if Map.fetch(result, :ok) != nil do
      latLon = address
        |> PocCadeEsseCepWeb.FindCepService.formatAddress
        |> PocCadeEsseCepWeb.FindCepService.findLatLongFronAddress

      render(conn, "result.html", result: result.ok, lat: latLon.lat, lon: latLon.lon, zip: zip)
    else
      render(conn, "index.html", result: result.error, zip: zip)
    end
  end
end
