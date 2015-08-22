defmodule JwtClaims.Validation do
  @moduledoc """
  Validate registered claims

  see http://tools.ietf.org/html/rfc7519#section-4.1
  """

  alias JwtClaims.Claim

  @registered_claims [
    :exp
  ]

  @doc """
  Collect JWT claims that fail validation

  ## Example
      iex> seconds = Util.time_now - 1
      ...> claims = %{exp: seconds}
      ...> Validation.rejected(claims)
      [:exp]

  Returns a list containing any registered claims that fail validation
  """
  def rejected(claims, options \\ %{})
  def rejected(claims, options) do
    @registered_claims
    |> Enum.filter(&reject(&1, claims, options))
  end

  defp reject(key, {:ok, value}, options), do: apply(claim_module(key), :reject?, [value, options])
  defp reject(_, :error, _), do: false
  defp reject(key, claims, options), do: reject(key, Dict.fetch(claims, key), options)

  defp claim_module(:exp), do: Claim.Exp
end
