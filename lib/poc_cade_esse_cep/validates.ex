defmodule PocCadeEsseCep.Validades do
  @moduledoc "Um modulo de validação"

  def validate_size_zip_code(zip) when byte_size(zip) == 8, do: zip
  def validate_size_zip_code(_zip), do: {:error, "Não é válido"}
end
