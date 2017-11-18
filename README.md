# FyydEx

## TODOs

- [ ] Authorization
- [ ] Error Handling
  - [ ] Missing authorization
  - [ ] Doing smth really forbidden
  - [ ] Missing parameter
  - [ ] Unknown resource
- [ ] Account
  - [ ] GET /account/info
  - [ ] GET /account/curations
  - [ ] GET /account/collections
- [ ] User
  - [x] GET /user
  - [ ] GET /user/curations
    - [ ] GET /user/curations/episodes
  - [ ] GET /user/collections
    - [ ] GET /user/collections/podcasts
- [ ] Action
  - [ ] POST /action
  - [ ] GET /action
- [ ] Podcast
  - [ ] GET /podcast
    - [ ] GET /podcast/episodes
  - [ ] POST /podcast/action
  - [ ] GET /podcasts
  - [ ] GET /categories
  - [ ] GET /category
  - [ ] GET /podcast/recommend
  - [ ] GET /podcast/latest
- [ ] Episode
  - [ ] GET /episode
  - [ ] GET /episode/latest
- [ ] Curations
  - [ ] GET /curation
    - [ ] GET /curation/episodes
  - [ ] POST /curation
  - [ ] POST /curation/delete
  - [ ] POST /curate
  - [ ] GET /curate
  - [ ] GET /category/curation
- [ ] Collections
  - [ ] GET /collection
    - [ ] GET /collection/podcasts
  - [ ] POST /collection
  - [ ] POST /collection/delete
  - [ ] POST /collect
  - [ ] GET /collect
- [ ] Search
  - [ ] GET /search/episode
  - [ ] GET /search/podcast
  - [ ] GET /search/curation

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fyyd_ex](https://hexdocs.pm/fyyd_ex).

## Usage

### 😊 User

```elixir
# by id
user = Fyyd.User.get_user!(2078)

# or by id as String
user = Fyyd.User.get_user!("2078")

# or by nick
user = Fyyd.User.get_user_by_nick!("optikfluffel")
```
