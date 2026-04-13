# MyTaste

A personal catalogue for tracking movies, books, and recipes — inspired by Letterboxd.

**Live:** https://mytaste.onrender.com

---

## Features

- Search movies, books and recipes via TMDB, Open Library and TheMealDB APIs
- Add items to your personal list with status: Want / In progress / Completed
- Rate items with a 1–5 star rating
- Profile page with Chart.js statistics
- Global search across all three categories
- User authentication (sign up / log in)
- Dark UI with blurred hero covers

## Tech Stack

- **Ruby on Rails 7.1** — backend, routing, REST API
- **PostgreSQL** — database
- **Devise** — user authentication
- **Hotwire (Turbo + Stimulus)** — live search, interactive UI without full page reloads
- **Chart.js** — profile statistics charts
- **Active Storage + Cloudinary** — image uploads
- **TMDB / Open Library / TheMealDB** — external API integrations
- **Pagy** — pagination
- **RSpec + FactoryBot** — 45 model and request tests
- **Deployed on Render**

## Tests

```bash
bundle exec rspec
# 45 examples, 0 failures
```

Covers model validations and request specs for all three resources.

## Getting Started

```bash
git clone https://github.com/Kazybek10/mytaste.git
cd mytaste
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
