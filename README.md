# JWT (JSON Web Token) Claims

## Verification of a JWT Claims Set for Elixir

### Description

An Elixir implementation of the JSON Web Token (JWT) optional registered claims, [RFC 7519][rfc7519]

## Usage

Add JwtClaims as a dependency in your `mix.exs` file:

```elixir
defp deps do
  [{:jwt_claims, ">= 0.0"}]
end
```

[rfc7519]: http://tools.ietf.org/html/rfc7519
