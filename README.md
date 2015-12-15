# JWT Claims [![travis][ci_img]][travis] [![hex docs][hd_img]][hex_docs]

## Verification of a JWT (JSON Web Token) Claims Set for Elixir

### Description

An Elixir implementation of the JSON Web Token (JWT) optional registered claims, [RFC 7519][rfc7519]

## Usage

Add JwtClaims as a dependency in your `mix.exs` file:

```elixir
defp deps do
  [{:jwt_claims, "~> 0.0"}]
end
```

### JwtClaims.verify(jwt, options)

Returns a tuple, either:
* \{:ok, claims\}, a JWT claims set map, if the JWT Message Authentication Code (MAC), or signature, is verified and the registered claims are also verified
* \{:error, [rejected_claims]\}, a list of any registered claims that fail validation, if the JWT MAC is verified
* \{:error, "invalid JWT"\} if the JWT MAC is not verified
* \{:error, "invalid input"\} otherwise

`"jwt"` (required) is a JSON web token string

`options` (required) map

* **alg** (optional, default: `"HS256"`)
* **key** (required unless alg is "none")

Please refer to the [JSON Web Token][json_web_token] package for additional guidance regarding JWT options

Example

```elixir

secure_jwt_example = "eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFt.cGxlLmNvbS9pc19yb290Ijp0cnVlfQ.dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"

# verify with default algorithm, HMAC SHA256
{:ok, verified_claims} = JsonWebToken.verify(secure_jwt_example, %{key: "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C"})

```

### Supported registered claim names
* "**iss**" (Issuer)
* "**sub**" (Subject)
* "**aud**" (Audience)
* "**exp**" (Expiration Time)
* "**nbf**" (Not Before)
* "**iat**" (Issued At)
* "**jti**" (JWT ID)

### Supported Elixir versions
Elixir 1.1 and up

[rfc7519]: http://tools.ietf.org/html/rfc7519
[json_web_token]: https://github.com/garyf/json_web_token_ex

[travis]: https://travis-ci.org/garyf/jwt_claims_ex
[ci_img]: https://travis-ci.org/garyf/jwt_claims_ex.svg?branch=master
[hex_docs]: http://hexdocs.pm/jwt_claims
[hd_img]: http://img.shields.io/badge/docs-hexpm-blue.svg
