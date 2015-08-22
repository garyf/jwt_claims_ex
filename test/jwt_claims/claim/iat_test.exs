defmodule JwtClaims.Claim.IatTest do
  use ExUnit.Case

  alias JwtClaims.Claim.Iat
  alias JwtClaims.Util

  doctest Iat

  test "reject/1 w iat_time before now returns false" do
    iat_time = Util.time_now - 1
    refute Iat.reject?(iat_time)
  end

  test "reject/1 w iat_time after now returns true" do
    iat_time = Util.time_now + 1
    assert Iat.reject?(iat_time)
  end

  test "reject/1 w/o numeric iat_time returns true" do
    assert Iat.reject?("a")
  end
end
