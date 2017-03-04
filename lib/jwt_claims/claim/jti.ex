defmodule JwtClaims.Claim.Jti do
  @moduledoc """
  JWT ID

  see http://tools.ietf.org/html/rfc7519#section-4.1.7
  """

  alias JwtClaims.StringOrUri

  @doc """
  Predicate to reject a jti claim that does not match the expected JTI

  ## Example
      iex> Jti.reject?("jwt_id", %{iss: "other jwt_id"})
      true

  Returns `true` or `false`
  """
  def reject?(jti, options) do
    expected_jti = Map.get(options, :jti)
    !StringOrUri.present_and_equal?(jti, expected_jti)
  end
end
