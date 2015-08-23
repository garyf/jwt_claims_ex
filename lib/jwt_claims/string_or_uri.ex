defmodule JwtClaims.StringOrUri do
  @moduledoc """
  Validation helpers
  """

  @blank_string_re ~r{\A[[:space:]]*\z}

  @doc """
  Predicate to compare two strings for equality, and that both are present

  ## Example
      iex> StringOrUri.present_and_equal?("", "")
      false

  Returns `true` or `false`
  """
  def present_and_equal?(a, b) do
    present?(a) &&
      present?(b) &&
      a === b
  end

  @doc """
  A string is present if it is not blank

  Returns `false` if a string is blank, otherwise `true`
  """
  def present?(nil), do: false
  def present?(string), do: !blank?(string)

  @doc """
  A string is blank if it is empty or contains whitespaces only

  ## Example
      iex> StringOrUri.blank?(" ")
      true

  Returns `true` or `false`

  cf. rails activesupport/lib/active_support/core_ext/object/blank.rb
  """
  def blank?(nil), do: true
  def blank?(string) when is_binary(string) do
    @blank_string_re
    |> Regex.run(string)
    |> exact_match?(string)
  end
  def blank?(_), do: false

  defp exact_match?(nil, _), do: false
  defp exact_match?(capture, string) when is_list(capture), do: hd(capture) === string
  defp exact_match?(_, _), do: false
end
