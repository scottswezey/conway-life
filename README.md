# Conway-Life

In honor of John Conway, I rebuilt his Game of Life simulation in Elixir using Phoneix and LiveView.

## To run locally

* Requires Erlang/OTP 23+, Elixir 1.7+, NPM 7+.
* Install dependencies with `mix deps.get`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`
* Now you can play by visiting [`localhost:4000`](http://localhost:4000) from your browser.
* Access the dashboard at [`localhost:4000/dashboard`](http://localhost:4000/dashboard) in your browser. During development, the username is `scott` and the password is `secret`.

Want to run in production? Please [see the Phoenix deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Updating Live View:

* To force installation of the latest Javascript:
`(cd assets && npm install --force phoenix_live_view)`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
