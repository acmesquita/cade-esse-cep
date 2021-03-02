defmodule PocCadeEsseCep do
  alias PocCadeEsseCep.FindCepService

  defdelegate find_zip_code(zip_code), to: FindCepService, as: :call
end
