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
  @jwt_id "jwt_id"
  @subject "subject"

  @default_options %{
    aud: @uri,
    iss: @issuer,
    jti: @jwt_id,
    sub: @subject
  }

  @default_claims %{
    aud: [@uri, @recipient],
    exp: @after_now,
    iat: @before_now,
    iss: @issuer,
    jti: @jwt_id,
    nbf: @before_now,
    sub: @subject
  }

  @invalid_claims %{
    aud: ["http://www.other.com", "other recipient"],
    exp: @before_now,
    iat: @after_now,
    iss: "other issuer",
    jti: "other jwt_id",
    nbf: @after_now,
    sub: "other subject"
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
      :jti,
      :nbf,
      :sub
    ]
  end
end
