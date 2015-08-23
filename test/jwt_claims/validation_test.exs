defmodule JwtClaims.ValidationTest do
  use ExUnit.Case

  alias JwtClaims.Util
  alias JwtClaims.Validation

  doctest Validation

  @uri "http://www.example.com"
  @recipient "recipient"
  @aud [@uri, @recipient]

  @after_now Util.time_now + 1
  @before_now Util.time_now - 1

  @issuer "issuer"

  @default_options %{
    aud: @uri,
    iss: @issuer
  }

  @default_claims %{
    aud: [@uri, @recipient],
    exp: @after_now,
    iat: @before_now,
    iss: @issuer,
    nbf: @before_now
  }

  @invalid_claims %{
    aud: ["http://www.other.com", "other recipient"],
    exp: @before_now,
    iat: @after_now,
    iss: "other issuer",
    nbf: @after_now
  }

  test "rejected/2 w valid claims, returns empty list" do
    assert Validation.rejected(@default_claims, @default_options) == []
  end

  test "rejected/2 w invalid claims, returns list of rejected claims" do
    result = Validation.rejected(@invalid_claims, @default_options)
    assert result == [
      :aud,
      :exp,
      :iat,
      :iss,
      :nbf
    ]
  end
end
