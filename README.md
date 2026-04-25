# Percata

A personal catalogue for tracking movies, books, and recipes — inspired by Letterboxd.

**Live:** https://percata.onrender.com

---

## Features

- Search movies, books and recipes via TMDB, Open Library and TheMealDB APIs
- Add items to your personal list with status: Want / In progress / Completed
- Rate items with a 1–5 star rating
- Write notes and reviews for each item
- Custom watchlists with drag & drop sorting
- Global search across all three categories
- User authentication with avatar upload
- Profile page with activity stats
- Genre and year filters on index pages
- Dark UI with blurred hero covers

## Tech Stack

- **Ruby on Rails 7.1** — backend, routing, REST API
- **PostgreSQL** — database
- **Devise** — user authentication
- **Hotwire (Turbo + Stimulus)** — live search, interactive UI without full page reloads
- **Active Storage + Cloudinary** — image uploads
- **TMDB / Open Library / TheMealDB** — external API integrations
- **Pagy** — pagination
- **RSpec + FactoryBot** — 88 model and request tests
- **Deployed on Render**

## Tests

```bash
bundle exec rspec
# 88 examples, 0 failures
```

Covers model validations, associations and request specs for all resources.

## Getting Started

```bash
git clone https://github.com/Kazybek10/percata.git
cd percata
bundle install
cp .env.example .env  # add your TMDB_TOKEN
rails db:create db:migrate
rails server
```

## Screenshots

![Home](public/screenshots/screenshot-home.png)
![Movies](public/screenshots/screenshot-movies.png)
![Search](public/screenshots/screenshot-search.png)
![Books](public/screenshots/screenshot-books.png)
![Show page](public/screenshots/screenshot-show.png)

---

Built by [Kazybek Nurlanbek](https://github.com/Kazybek10) · Amsterdam
