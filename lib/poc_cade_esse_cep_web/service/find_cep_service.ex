defmodule PocCadeEsseCepWeb.FindCepService do

  def findAddress(zip) do
    zip
      |> PocCadeEsseCepWeb.Normalize.normalizeZipCode
      |> validateSizeZipCode
      |> sendCEP
  end

  def validateSizeZipCode(zip) do
    if String.length(zip) == 8 do
      zip
    else
      {:error, "Não é válido"}
    end
  end
  
  def sendCEP(zip) when is_tuple zip do
    zip
  end

  def sendCEP(zip) when is_bitstring zip do
    result = HTTPotion.get("https://brasilapi.com.br/api/cep/v1/#{zip}").body
    |> Jason.decode
    |> elem(1)
    
    if result["errors"] != nil do
      {:error, "Cep não localizado"}
    else
      {:ok, result}
    end
  end

  def findLatLongFronAddress(address) do
    try do
    url = "https://nominatim.openstreetmap.org/?addressdetails=1&q=#{address}&format=json&limit=1&email=catha.ana.1994@gmail.com&countrycodes=BR"
    body = HTTPotion.get(url, ["Content-type": "application/json; charset=UTF-8"]).body
      |> Jason.decode
      |> elem(1)

    [address | _] = body
    
    %{lon: address["lon"], lat: address["lat"]}
    rescue
      e in MatchError -> %{lon: "-5.0978005", lat: "-42.7955089"}
    end
  end

  def formatAddress(body) do
    body["state"] <> "+" <> body["street"] <> "+" <> body["neighborhood"]
    |> String.replace(" ", "+")
    |> PocCadeEsseCepWeb.Normalize.normalizeToUTF8
  end
 
end
