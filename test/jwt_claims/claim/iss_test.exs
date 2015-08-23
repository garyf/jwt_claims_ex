defmodule JwtClaims.Claim.IssTest do
  use ExUnit.Case

  alias JwtClaims.Claim.Iss

  doctest Iss

  @issuer "issuer"

  test "reject?/2 w :iss claim a string w match" do
    refute Iss.reject?(@issuer, %{iss: @issuer})
  end

  test "reject?/2 w :iss claim a string w/o match" do
    assert Iss.reject?(@issuer, %{iss: "not issuer"})
  end

  test "reject?/2 w :iss claim an empty string" do
    assert Iss.reject?("", %{iss: @issuer})
  end

  test "reject?/2 w options[:iss] an empty string" do
    assert Iss.reject?(@issuer, %{iss: ""})
  end
end
