# MyTaste

A personal catalogue for tracking movies, books, and recipes you love.

**Live:** https://mytaste.onrender.com

---

## Features

- Browse and add movies, books, and recipes
- Upload cover images for each item
- Rate items with a star rating (1–5)
- Global search across all three categories
- User authentication (sign up / log in)
- Responsive dark UI

## Tech Stack

- **Ruby on Rails 7.1** — backend, routing, authentication
- **PostgreSQL** — database
- **Devise** — user authentication
- **Hotwire (Turbo + Stimulus)** — modal forms, live search, interactive UI
- **Active Storage + Cloudinary** — image uploads
- **Pagy** — pagination
- **Deployed on Render**

## Getting Started

```bash
git clone https://github.com/Kazybek10/mytaste.git
cd mytaste
bundle install
rails db:create db:migrate db:seed
rails server
```

## Screenshots

> Movies, Books and Recipes — vertical card layout with cover images

> Show page — blurred hero background with cover, tags, rating and description

---

Built by [Kazybek Nurlanbek](https://github.com/Kazybek10) · Amsterdam
