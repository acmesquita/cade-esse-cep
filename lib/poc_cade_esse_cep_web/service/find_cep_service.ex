defmodule PocCadeEsseCepWeb.FindCepService do

  def normalizeZipCode(zip) do
    zip |> String.replace( "-", "")
  end

  def validateSizeZipCode(zip) do
    if String.length(zip) == 8 do
      {:ok, true}
    else
      {:error, "Não é válido"}
    end
  end

end