defmodule JwtClaims.ValidationTest do
  use ExUnit.Case

  alias JwtClaims.Util
  alias JwtClaims.Validation

  doctest Validation

  @after_now Util.time_now + 1
  @before_now Util.time_now - 1

  @default_claims %{
    exp: @after_now
  }

  @invalid_claims %{
    exp: @before_now
  }

  test "rejected/2 w valid claims, returns empty list" do
    assert Validation.rejected(@default_claims, @default_options) == []
  end

  test "rejected/2 w invalid claims, returns list of rejected claims" do
    result = Validation.rejected(@invalid_claims, @default_options)
    assert result == [
      :exp
    ]
  end
end
