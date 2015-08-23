defmodule JwtClaims.Claim.Sub do
  @moduledoc """
  Subject

  see http://tools.ietf.org/html/rfc7519#section-4.1.2
  """

  alias JwtClaims.StringOrUri

  @doc """
  Predicate to reject a sub claim that does not match the expected subject

  ## Example
      iex> Sub.reject?("subject", %{sub: "other subject"})
      true

  Returns `true` or `false`
  """
  def reject?(sub, options) do
    expected_subject = Dict.get(options, :sub)
    !StringOrUri.present_and_equal?(sub, expected_subject)
  end
end
