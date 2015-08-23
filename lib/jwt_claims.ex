defmodule JwtClaims do
  @moduledoc """
  Verify JSON Web Token (JWT) claims

  see http://tools.ietf.org/html/rfc7519#section-4.1
  """

  alias JwtClaims.Validation

  @doc """
  Verify a JWT having registered claims

  ## Examples
      iex> seconds = Util.time_now - 1
      ...> claims = %{exp: seconds}
      ...> JwtClaims.verify({:ok, claims})
      {:error, [:exp]}

      iex> jwt_w_exp_before_now = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZSwiZXhwIjoxMzAwODE5MzgwfQ.Ktfu3EdLz0SpuTIMpMoRZMtZsCATWJHeDEBGrsZE6LI"
      ...> hs256_key = "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C"
      ...> options = %{iss: "joe", key: hs256_key}
      ...> {:error, rejected_claims} = JwtClaims.verify(jwt_w_exp_before_now, options)
      ...> rejected_claims
      [:exp]

  Returns a tuple, either:
  * {:ok, claims}, a JWT claims set map, if the JWT Message Authentication Code (MAC), or signature, is verified and the registered claims are also verified
  * {:error, [rejected_claims]}, a list of any registered claims that fail validation, if the JWT MAC is verified
  * {:error, "invalid JWT"} if the JWT MAC is not verified
  * {:error, "invalid input"} otherwise
  """
  def verify(input, options \\ %{})
  def verify(jwt, options) when is_binary(jwt), do: verify(JsonWebToken.verify(jwt, options), options)
  def verify({:ok, claims}, options), do: result(Validation.rejected(claims, options), claims)
  def verify({:error, _}, _), do: {:error, "invalid JWT"}
  def verify(_, _), do: {:error, "invalid input"}

  defp result([], claims), do: {:ok, claims}
  defp result(rejected_claims, _), do: {:error, rejected_claims}
end
