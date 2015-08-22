defmodule JwtClaims.Util do
  @moduledoc "Utility functions"

  @m 1_000_000

  @doc """
  Time interval in seconds (floating point) since the Unix Epoch, 1970-01-01T00:00:00Z UTC,
  ignoring leap seconds

  cf. timex time.ex; https://github.com/bitwalker/timex
  """
  def time_now, do: to_seconds(:os.timestamp)

  @doc false
  def to_seconds({_, _, _} = timestamp), do: to_micro_seconds(timestamp) / @m

  defp to_micro_seconds({mega, sec, micro}), do: (mega * @m + sec) * @m + micro
end
