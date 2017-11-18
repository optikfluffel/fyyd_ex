# FyydEx

[![Build Status](https://travis-ci.org/optikfluffel/fyyd_ex.svg?branch=master)](https://travis-ci.org/optikfluffel/fyyd_ex)
[![Coverage Status](https://coveralls.io/repos/github/optikfluffel/fyyd_ex/badge.svg?branch=master)](https://coveralls.io/github/optikfluffel/fyyd_ex?branch=master)

⚠️ WORK IN PROGRESS: A basic wrapper for the [Fyyd API](https://github.com/eazyliving/fyyd-api).

<!-- TODO: uncomment when ready
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fyyd_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fyyd_ex, "~> 0.1.0"}
  ]
end
```

_Also make sure you have these three environtment variables set correctly_:

- `FYYD_CLIENT_ID`
- `FYYD_CLIENT_SECRET`
- `FYYD_OAUTH_CALLBACK_URL`

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fyyd_ex](https://hexdocs.pm/fyyd_ex). -->

## Usage

### 😊 User

```elixir
# by id
{:ok, user} = Fyyd.user(2078)
{:ok, user} = Fyyd.user("2078")

# or by nick
{:ok, user} = Fyyd.user_by_nick("optikfluffel")
```

### 📂 Curations

```elixir
# for a specific user by id
{:ok, curations} = Fyyd.curations_for_user(2078)
{:ok, curations} = Fyyd.curations_for_user("2078")

# for a specific user by nick
{:ok, curations} = Fyyd.curations_for_user_by_nick("optikfluffel")
```
