defmodule JwtClaims.Claim.StringOrUriTest do
  use ExUnit.Case

  alias JwtClaims.StringOrUri

  doctest StringOrUri

  test "blank?/1" do
    assert StringOrUri.blank?(nil)
    assert StringOrUri.blank?("")
    assert StringOrUri.blank?("   ")
    assert StringOrUri.blank?("\t\n\r")

    refute StringOrUri.blank?("foo")
    refute StringOrUri.blank?("bar ")
  end
end
