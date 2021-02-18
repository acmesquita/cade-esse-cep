defmodule PocCadeEsseCepWeb.Validades do
  @moduledoc "Um modulo de validação"

  def validate_size_zip_code(zip) when zip |> length == 8, do: zip
  def validate_size_zip_code(_zip), do: {:error, "Não é válido"}
end
