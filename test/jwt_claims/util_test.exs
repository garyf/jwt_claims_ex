defmodule JwtClaims.UtilTest do
  use ExUnit.Case

  alias JwtClaims.Util

  test "to_seconds" do
    assert Util.to_seconds({1234, 567890, 123456}) == 1234567890.123456
  end
end
