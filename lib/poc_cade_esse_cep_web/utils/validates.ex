defmodule PocCadeEsseCepWeb.Validades do
  def validateSizeZipCode(zip) do
    if String.length(zip) == 8 do
      zip
    else
      {:error, "Não é válido"}
    end
  end
end