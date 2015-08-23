defmodule JwtClaims.Claim.StringOrUriTest do
  use ExUnit.Case

  alias JwtClaims.StringOrUri

  doctest StringOrUri

  test "present_and_equal?/2 w equality" do
    assert StringOrUri.present_and_equal?("foo", "foo")
  end

  defp with_blank_or_not_equal(a, b) do
    refute StringOrUri.present_and_equal?(a, b)
  end

  test "present_and_equal?/2 w 1st argument blank", do: with_blank_or_not_equal("", "b")

  test "present_and_equal?/2 w 2nd argument blank", do: with_blank_or_not_equal("a", "")

  test "present_and_equal?/2 w/o equality", do: with_blank_or_not_equal("foo", "bar")

  test "blank?/1" do
    assert StringOrUri.blank?(nil)
    assert StringOrUri.blank?("")
    assert StringOrUri.blank?("   ")
    assert StringOrUri.blank?("\t\n\r")

    refute StringOrUri.blank?("foo")
    refute StringOrUri.blank?("bar ")
  end
end
