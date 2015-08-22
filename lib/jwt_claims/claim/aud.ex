defmodule JwtClaims.Claim.Aud do
  @moduledoc """
  Audience

  see http://tools.ietf.org/html/rfc7519#section-4.1.3
  """

  alias JwtClaims.StringOrUri

  @doc """
  Predicate to reject an audience claim value that does not include the recipient

  ## Example
      iex> recipient = "recipient"
      ...> aud = [recipient]
      ...> Aud.reject?(aud, %{aud: recipient})
      false

  Returns `true` or `false`
  """
  def reject?(aud, options \\ %{})
  def reject?(aud, options) when is_list(aud) do
    expected_recipient = Dict.get(options, :aud)
    !present_and_member?(aud, expected_recipient)
  end
  def reject?(aud, options), do: reject?([aud], options)

  defp present_and_member?(collection, value) do
    StringOrUri.present?(value) &&
      Enum.member?(collection, value)
  end
end
