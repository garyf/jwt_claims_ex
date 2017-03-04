defmodule JwtClaims.Claim.Iss do
  @moduledoc """
  Issuer

  see http://tools.ietf.org/html/rfc7519#section-4.1.1
  """

  alias JwtClaims.StringOrUri

  @doc """
  Predicate to reject an iss claim that does not match the expected issuer

  ## Example
      iex> Iss.reject?("issuer", %{iss: "other issuer"})
      true

  Returns `true` or `false`
  """
  def reject?(iss, options) do
    expected_issuer = Map.get(options, :iss)
    !StringOrUri.present_and_equal?(iss, expected_issuer)
  end
end
