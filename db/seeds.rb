# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Movie.create([
  { title: 'Sister without drive' },
  { title: 'Almost buy statement' },
  { title: 'Under common' },
  { title: 'Skill design lay' },
  { title: 'Girl home share' },
  { title: 'Toward produce' },
  { title: 'Can hour recently finish' },
  { title: 'Smile possible' },
  { title: 'Nor' },
  { title: 'Matter crime charge' }
])

Book.create([
  { title: 'System value employee player record' },
  { title: 'Up your threat easy letter' },
  { title: 'Laugh single another' },
  { title: 'Surface choice' },
  { title: 'Performance only century radio' },
  { title: 'Campaign check' },
  { title: 'Political room international tough' },
  { title: 'Evening which' },
  { title: 'Marriage improve' },
  { title: 'Wonder theory' }
])

Recipe.create([
  { title: 'Together bad series another' },
  { title: 'Participant side dream home' },
  { title: 'Approach some answer sit cup my' },
  { title: 'Behavior executive production suffer' },
  { title: 'Skin lead term too' },
  { title: 'Ready light ten late' },
  { title: 'Management dream kid' },
  { title: 'Scene speak decide exactly wrong half' },
  { title: 'By beyond material among foot' },
  { title: 'Who kid house over' }
])
