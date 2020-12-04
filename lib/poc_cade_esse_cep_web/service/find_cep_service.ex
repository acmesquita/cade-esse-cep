defmodule PocCadeEsseCepWeb.FindCepService do

  def normalizeZipCode(zip) do
    zip |> String.replace( "-", "")
  end

  def validateSizeZipCode(zip) do
    if String.length(zip) == 8 do
      zip
    else
      {:error, "Não é válido"}
    end
  end

  def sendCEP(zip) do
    HTTPotion.get("https://brasilapi.com.br/api/cep/v1/#{zip}").body
    |> Jason.decode
    |> elem(1)
  end

  def normalizeAddress(body) do
    if body["errors"] do
      %{:error => "Não foi encontrado o CEP"}
    else
      %{:ok => body["street"] <> ", " <> body["neighborhood"] <> "\n" <> body["city"] <> ", " <> body["state"] }
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
    unless body["errors"] do
      body["state"] <> "+" <> body["street"] <> "+" <> body["neighborhood"]
      |> String.replace(" ", "+")
      |> PocCadeEsseCepWeb.FindCepService.normalizeToUTF8
    end
  end

  def normalizeToUTF8(text) do
    text
      |> String.replace("ç", "c")
      |> String.replace("Ç", "C")
      |> String.replace("é", "e")
      |> String.replace("É", "E")
      |> String.replace("ê", "e")
      |> String.replace("Ê", "E")
      |> String.replace("á", "a")
      |> String.replace("Á", "&Aacute;")
      |> String.replace("â", "&acirc;")
      |> String.replace("Â", "&Acirc;")
      |> String.replace("à", "&agrave;")
      |> String.replace("À", "&Agrave;")
      |> String.replace("ã", "&atilde;")
      |> String.replace("Ã", "&Atilde;")
      |> String.replace("ª", "&ordf;")
      |> String.replace("Í", "&Iacute;")
      |> String.replace("í", "&iacute;")
      |> String.replace("Î", "&Icirc;")
      |> String.replace("î", "&icirc;")
      |> String.replace("Ì", "&Igrave;")
      |> String.replace("ì", "&igrave;")
      |> String.replace("Ï", "&Iuml;")
      |> String.replace("ï", "&iuml;")
      |> String.replace("ó", "&oacute;")
      |> String.replace("Ó", "&Oacute;")
      |> String.replace("ò", "&ograve;")
      |> String.replace("Ò", "&Ograve;")
      |> String.replace("ô", "&ocirc;")
      |> String.replace("Ô", "&Ocirc;")
      |> String.replace("õ", "&otilde;")
      |> String.replace("Õ", "&Otilde;")
      |> String.replace("º", "&ordm;")
      |> String.replace("Ú", "&Uacute;")
      |> String.replace("ú", "&uacute;")
      |> String.replace("Û", "&Ucirc;")
      |> String.replace("û", "&ucirc;")
      |> String.replace("Ù", "&Ugrave;")
      |> String.replace("ù", "&ugrave;")
      |> String.replace("Ü", "&Uuml;")
      |> String.replace("ü", "&uuml;")
      |> String.replace("%", "&#37;")
  end
end
