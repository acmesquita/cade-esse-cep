defmodule PocCadeEsseCepWeb.Validades do
  @moduledoc "Um modulo de validação"

  def validate_size_zip_code(zip) do
    if String.length(zip) == 8 do
      zip
    else
      {:error, "Não é válido"}
    end
  end
end