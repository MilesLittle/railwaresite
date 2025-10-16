
# RailwareSite

A Rails 7.1 blog-style web application built with Ruby 3.2.3, PostgreSQL, Hotwire (Turbo + Stimulus), and modern JS/CSS tooling (esbuild, Sass, PostCSS). The app provides users, posts, categories, comments, and a simple inbox messaging model.

This README covers development setup, common commands, testing, basic deployment guidance, and troubleshooting tips.

## Quick facts

- Ruby: 3.2.3
- Rails: ~> 7.1.3
- Database: PostgreSQL (via `pg` gem)
- JS bundler: esbuild
- CSS: Sass + PostCSS (autoprefixer)
- Hotwire: Turbo + Stimulus

## Getting started (development)

Prerequisites

- Ruby 3.2.3 (rbenv, rvm, or asdf recommended)
- Node.js (recommended: 18+)
- Yarn (the repo uses yarn scripts, though npm also works)
- PostgreSQL
- Optional: libvips or ImageMagick if you need Active Storage image processing

1. Clone the repo

```bash
git clone <repo-url>
cd railwaresite
```

2. Install Ruby gems

```bash
bundle install
```

3. Install JavaScript dependencies

```bash
yarn install
```

4. Configure the database

If you need to tweak DB credentials, edit `config/database.yml`. Then create and migrate the database and optionally seed data:

```bash
rails db:create db:migrate db:seed
```

5. Build frontend assets

- Build JS

```bash
yarn build
```

- Build CSS

```bash
yarn build:css
```

During development you can watch CSS changes automatically:

```bash
yarn watch:css
```

6. Start the Rails server

```bash
bin/rails server
```

Visit http://localhost:3000

## Common commands

- Start server: `bin/rails server`
- Console: `bin/rails console`
- DB setup: `rails db:create db:migrate db:seed`
- Run the test suite: `rails test`
- Build JS: `yarn build`
- Build CSS: `yarn build:css`
- Watch CSS: `yarn watch:css`

## Testing

This app uses Rails' built-in testing framework. Run all tests with:

```bash
rails test
```


## Environment variables & secrets

Typical environment variables used in production deployments:

- `DATABASE_URL` — Postgres connection string
- `RAILS_MASTER_KEY` — rails credentials master key (required to read `credentials.yml.enc`)
- `SECRET_KEY_BASE` — (usually provided through credentials or env)

Set these in your deployment platform (Render, Heroku, Docker secrets, etc.).


```bash
RAILS_ENV=production rails assets:precompile
```

Docker / Render notes

- This project contains a `Dockerfile` and `render.yaml` — inspect and adapt them to your environment. Ensure the build step runs the Node/Yarn asset builds and `rails assets:precompile` when producing production images.

## Project layout (high level)

- `app/controllers` — main controllers (posts, users, sessions, categories, comments)
- `app/models` — ActiveRecord models
- `app/views` — ERB/HAML templates and partials
- `app/javascript` — Stimulus controllers and JS entrypoints
- `app/assets/stylesheets` — Sass styles (Bootstrap based)
- `config` — routes, environments, and other app configuration


## Contributing

1. Fork the repo and create a branch for your change
2. Add tests for any new behavior
3. Open a pull request with a clear description
