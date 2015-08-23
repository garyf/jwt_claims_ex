defmodule JwtClaimsTest do
  use ExUnit.Case

  alias JwtClaims.Util

  doctest JwtClaims

  @after_now Util.time_now + 1
  @before_now Util.time_now - 1

  test "verify/2 w rejected_claims" do
    claims = %{exp: @before_now}
    {:error, rejected_claims} = JwtClaims.verify({:ok, claims})
    assert rejected_claims == [:exp]
  end

  test "verify/2 w/o rejected_claims" do
    claims = %{exp: @after_now}
    {:ok, verified_claims} = JwtClaims.verify({:ok, claims})
    assert verified_claims == claims
  end

  test "verify/2 w invalid JWT" do
    claims = %{exp: @after_now}
    {:error, message} = JwtClaims.verify({:error, claims})
    assert message == "invalid JWT"
  end

  test "verify/2 w invalid input" do
    claims = %{exp: @after_now}
    {:error, message} = JwtClaims.verify({:foo, claims})
    assert message == "invalid input"
  end

  @jwt_w_exp_before_now_w_iss_joe "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqb2UiLCJodHRwOi8vZXhhbXBsZS5jb20vaXNfcm9vdCI6dHJ1ZSwiZXhwIjoxMzAwODE5MzgwfQ.Ktfu3EdLz0SpuTIMpMoRZMtZsCATWJHeDEBGrsZE6LI"

  @hs256_key "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C"

  test "JsonWebToken integration w :exp claim before now w :iss claim matching" do
    options = %{iss: "joe", key: @hs256_key}
    {:error, rejected_claims} = JwtClaims.verify(@jwt_w_exp_before_now_w_iss_joe, options)
    assert rejected_claims == [:exp]
  end

  test "JsonWebToken integration w :exp claim before now w/o :iss claim matching" do
    options = %{iss: "mary", key: @hs256_key}
    {:error, rejected_claims} = JwtClaims.verify(@jwt_w_exp_before_now_w_iss_joe, options)
    assert rejected_claims == [:exp, :iss]
  end
end
