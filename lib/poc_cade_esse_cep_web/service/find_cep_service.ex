defmodule PocCadeEsseCepWeb.FindCepService do

  def findAddress(zip) do
    zip
      |> PocCadeEsseCepWeb.Normalize.normalizeZipCode
      |> PocCadeEsseCepWeb.Validades.validateSizeZipCode
      |> findCEP
  end
  
  defp findCEP(zip) when is_tuple zip do
    zip
  end

  defp findCEP(zip) when is_bitstring zip do
    result = HTTPotion.get("https://brasilapi.com.br/api/cep/v1/#{zip}").body
    |> Jason.decode
    |> elem(1)

    if result["errors"] != nil do
      {:error, "Cep não localizado"}
    else
      {:ok, result}
    end
  end

  def findLatLongFromAddress(address) do
    try do
      url = generateURLNominatim(address)
      body = HTTPotion.get(url, ["Content-type": "application/json; charset=UTF-8"]).body
        |> Jason.decode
        |> elem(1)

      [address | _] = body
      
      %{lon: address["lon"], lat: address["lat"]}
    rescue
      e in MatchError -> %{lon: "-5.0978005", lat: "-42.7955089"}
    end
  end

  defp generateURLNominatim(address) do
    "https://nominatim.openstreetmap.org/?addressdetails=1&q=#{address}&format=json&limit=1&email=catha.ana.1994@gmail.com&countrycodes=BR"
  end
 
end
