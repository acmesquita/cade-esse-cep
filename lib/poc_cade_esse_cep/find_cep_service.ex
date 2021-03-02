defmodule PocCadeEsseCep.FindCepService do
  @moduledoc "Modulo de encontrar um CEP"

  alias PocCadeEsseCep.{Normalize, Validades}

  def call(zip) do
    zip
      |> Normalize.normalize_zip_code()
      |> Validades.validate_size_zip_code()
      |> find_zip_code()
  end

  defp find_zip_code({:error, _reson} = error), do: error
  defp find_zip_code(zip) do
    HTTPotion.get("https://brasilapi.com.br/api/cep/v1/#{zip}").body
    |> Jason.decode
    |> elem(1)
    |> handle_zip_code()
  end

  defp handle_zip_code(%{errors: _errors}), do: {:error, "Cep não localizado"}
  defp handle_zip_code(result), do: {:ok, result}

  def find_lat_long_from_address(address) do
    try do
      url = generate_url_nominatim(address)
      body = HTTPotion.get(url, ["Content-type": "application/json; charset=UTF-8"]).body
        |> Jason.decode
        |> elem(1)

      [address | _] = body

      %{lon: address["lon"], lat: address["lat"]}
    rescue
      _e in MatchError -> %{lon: "-5.0978005", lat: "-42.7955089"}
    end
  end

  defp generate_url_nominatim(address) do
    "https://nominatim.openstreetmap.org/?addressdetails=1&q=#{address}&format=json&limit=1&email=catha.ana.1994@gmail.com&countrycodes=BR"
  end

end
