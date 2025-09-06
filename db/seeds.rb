user = User.find_or_create_by!(email: 'admin@admin.com') do |u|
  u.password = 'secret123'
  u.password_confirmation = 'secret123'
end

# Удаляем все существующие записи, чтобы избежать дублирования
user.books.destroy_all
user.movies.destroy_all
user.recipes.destroy_all

# Создаем фильмы
movies = [
  { title: 'Sister without drive', release_year: 2020, director: 'John Smith', description: 'Короткое описание фильма' },
  { title: 'Almost buy statement', release_year: 2021, director: 'Jane Doe', description: 'Короткое описание фильма' },
  { title: 'Under common', release_year: 2019, director: 'Mike Johnson', description: 'Короткое описание фильма' },
  { title: 'Skill design lay', release_year: 2022, director: 'Sarah Wilson', description: 'Короткое описание фильма' },
  { title: 'Girl home share', release_year: 2020, director: 'Tom Brown', description: 'Короткое описание фильма' },
  { title: 'Toward produce', release_year: 2021, director: 'Lisa Davis', description: 'Короткое описание фильма' },
  { title: 'Can hour recently finish', release_year: 2018, director: 'David Miller', description: 'Короткое описание фильма' },
  { title: 'Smile possible', release_year: 2023, director: 'Emma White', description: 'Короткое описание фильма' },
  { title: 'Nor', release_year: 2020, director: 'Chris Lee', description: 'Короткое описание фильма' },
  { title: 'Matter crime charge', release_year: 2021, director: 'Anna Garcia', description: 'Короткое описание фильма' }
]

movies.each do |movie_data|
  movie = user.movies.find_or_create_by!(title: movie_data[:title]) do |m|
    m.release_year = movie_data[:release_year]
    m.director = movie_data[:director]
    m.description = movie_data[:description]
  end
  
  # Генерируем URL изображения-заполнителя на основе названия фильма
  image_url = "https://placehold.co/600x400/2A2F4F/FFFFFF?text=#{movie.title.gsub(' ', '+')}"
  
  # Используем OpenURI для загрузки изображения
  require "open-uri"
  
  # Прикрепляем файл к модели через Active Storage
  downloaded_image = URI.open(image_url)
  movie.cover_image.attach(io: downloaded_image, filename: "#{movie.title.parameterize}.png")
end

# Создаем книги
books = [
  { title: 'System value employee player record', author: 'Robert Johnson', publish_year: 2015, description: 'Короткое описание книги' },
  { title: 'Up your threat easy letter', author: 'Mary Williams', publish_year: 2016, description: 'Короткое описание книги' },
  { title: 'Laugh single another', author: 'James Brown', publish_year: 2017, description: 'Короткое описание книги' },
  { title: 'Surface choice', author: 'Patricia Davis', publish_year: 2018, description: 'Короткое описание книги' },
  { title: 'Performance only century radio', author: 'Michael Wilson', publish_year: 2019, description: 'Короткое описание книги' },
  { title: 'Campaign check', author: 'Linda Anderson', publish_year: 2020, description: 'Короткое описание книги' },
  { title: 'Political room international tough', author: 'David Taylor', publish_year: 2021, description: 'Короткое описание книги' },
  { title: 'Evening which', author: 'Susan Martinez', publish_year: 2022, description: 'Короткое описание книги' },
  { title: 'Marriage improve', author: 'Christopher Garcia', publish_year: 2023, description: 'Короткое описание книги' },
  { title: 'Wonder theory', author: 'Jennifer Rodriguez', publish_year: 2024, description: 'Короткое описание книги' }
]
books.each do |book_data|
  Book.find_or_create_by!(title: book_data[:title], user: user) do |b|
    b.author = book_data[:author]
    b.publish_year = book_data[:publish_year]
    b.description = book_data[:description]
  end
end

# Создаем рецепты
recipes = [
  { title: 'Together bad series another', ingredients: 'Flour, sugar, eggs, milk', instructions: 'Mix all ingredients and bake at 350F for 30 minutes' },
  { title: 'Participant side dream home', ingredients: 'Chicken, rice, vegetables, spices', instructions: 'Cook chicken with spices, serve with rice and vegetables' },
  { title: 'Approach some answer sit cup my', ingredients: 'Beef, potatoes, carrots, onion', instructions: 'Stew beef with vegetables for 2 hours until tender' },
  { title: 'Behavior executive production suffer', ingredients: 'Salmon, lemon, herbs, olive oil', instructions: 'Grill salmon with lemon and herbs for 15 minutes' },
  { title: 'Skin lead term too', ingredients: 'Pasta, tomato sauce, cheese, basil', instructions: 'Boil pasta, add sauce and cheese, garnish with basil' },
  { title: 'Ready light ten late', ingredients: 'Shrimp, garlic, butter, parsley', instructions: 'Sauté shrimp with garlic and butter, sprinkle with parsley' },
  { title: 'Management dream kid', ingredients: 'Lamb, rosemary, garlic, potatoes', instructions: 'Roast lamb with herbs and potatoes for 2 hours' },
  { title: 'Scene speak decide exactly wrong half', ingredients: 'Tuna, avocado, cucumber, soy sauce', instructions: 'Mix tuna with vegetables and soy sauce for sushi' },
  { title: 'By beyond material among foot', ingredients: 'Pork, apples, sage, onion', instructions: 'Roast pork with apples and sage for 1.5 hours' },
  { title: 'Who kid house over', ingredients: 'Duck, orange, honey, thyme', instructions: 'Roast duck with orange glaze for 1 hour' }
]
recipes.each do |recipe_data|
  Recipe.find_or_create_by!(title: recipe_data[:title], user: user) do |r|
    r.ingredients = recipe_data[:ingredients]
    r.instructions = recipe_data[:instructions]
  end
end

puts "Создано #{User.count} пользователей, #{Book.count} книг, #{Movie.count} фильмов и #{Recipe.count} рецептов."
