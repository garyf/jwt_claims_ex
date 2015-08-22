defmodule JwtClaims.Claim.NbfTest do
  use ExUnit.Case

  alias JwtClaims.Claim.Nbf
  alias JwtClaims.Util

  doctest Nbf

  test "reject/1 w nbf_time now returns false" do
    nbf_time = Util.time_now
    refute Nbf.reject?(nbf_time)
  end

  test "reject/1 w nbf_time after now returns true" do
    nbf_time = Util.time_now + 1
    assert Nbf.reject?(nbf_time)
  end

  test "reject/1 w/o numeric nbf_time returns true" do
    assert Nbf.reject?("a")
  end
end
