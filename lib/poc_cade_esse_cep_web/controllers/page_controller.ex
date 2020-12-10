defmodule PocCadeEsseCepWeb.PageController do
  use PocCadeEsseCepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", result: "")
  end

  def show(conn, %{"page" => %{ "zip" => zip}}) do
    address = zip 
      |> PocCadeEsseCepWeb.FindCepService.findAddress
      
    {status, result} = address

    IO.puts(status)

    if status != :error  do
      addressNormalize = result |> PocCadeEsseCepWeb.Normalize.normalizeAddress

      latLon =  result
        |> PocCadeEsseCepWeb.FindCepService.formatAddress
        |> PocCadeEsseCepWeb.FindCepService.findLatLongFronAddress

      render(conn, "result.html", result: addressNormalize.ok, lat: latLon.lat, lon: latLon.lon, zip: zip)
    else
      render(conn, "index.html", result: result, zip: zip)
    end
  end
end
