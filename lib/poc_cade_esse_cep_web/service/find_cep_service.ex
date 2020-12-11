defmodule PocCadeEsseCepWeb.FindCepService do

  def find_address(zip) do
    zip
      |> PocCadeEsseCepWeb.Normalize.normalize_zip_code
      |> PocCadeEsseCepWeb.Validades.validate_size_zip_code
      |> find_zip_code
  end1
  
  defp find_zip_code(zip) when is_tuple zip do
    zip
  end

  defp find_zip_code(zip) when is_bitstring zip do
    result = HTTPotion.get("https://brasilapi.com.br/api/cep/v1/#{zip}").body
    |> Jason.decode
    |> elem(1)

    if result["errors"] != nil do
      {:error, "Cep não localizado"}
    else
      {:ok, result}
    end
  end

  def find_lat_long_from_address(address) do
    try do
      url = generate_url_nominatim(address)
      body = HTTPotion.get(url, ["Content-type": "application/json; charset=UTF-8"]).body
        |> Jason.decode
        |> elem(1)

      [address | _] = body
      
      %{lon: address["lon"], lat: address["lat"]}
    rescue
      e in MatchError -> %{lon: "-5.0978005", lat: "-42.7955089"}
    end
  end

  defp generate_url_nominatim(address) do
    "https://nominatim.openstreetmap.org/?addressdetails=1&q=#{address}&format=json&limit=1&email=catha.ana.1994@gmail.com&countrycodes=BR"
  end
 
end
