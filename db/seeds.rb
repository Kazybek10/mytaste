# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Этот код будет работать во всех средах (разработка, тест, продакшн).
# Это обеспечивает, что основные данные всегда создаются.

Movie.create!([
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
])

Book.create!([
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
])

Recipe.create!([
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
])

# Этот блок предназначен только для создания администратора в среде разработки
if Rails.env.development?
  admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@admin.com')
  admin_password = ENV.fetch('ADMIN_PASSWORD', 'secret123')

  user = User.find_or_initialize_by(email: admin_email)
  if user.new_record?
    user.password = admin_password
    user.password_confirmation = admin_password
    user.save!
    puts "Admin created: #{admin_email}"
  else
    puts "Admin already exists: #{admin_email}"
  end
end
