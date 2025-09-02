#!/usr/bin/env ruby

# Простой скрипт для тестирования пагинации
# Запустите: ruby test_pagination.rb

puts "=== Тест пагинации MyTaste ==="
puts

# Проверяем количество записей
puts "1. Проверка количества записей:"
puts "   - Книги: #{Book.count}"
puts "   - Фильмы: #{Movie.count}" 
puts "   - Рецепты: #{Recipe.count}"
puts

# Проверяем настройки пагинации
puts "2. Настройки пагинации:"
puts "   - Элементов на страницу: #{Pagy::DEFAULT[:items]}"
puts "   - Размер навигации: #{Pagy::DEFAULT[:size]}"
puts

# Тестируем пагинацию для книг
puts "3. Тест пагинации для книг:"
books_scope = Book.all.order(created_at: :desc)
pagy, books = Pagy.new(books_scope, items: 2)

puts "   - Всего записей: #{books_scope.count}"
puts "   - Записей на странице: #{books.count}"
puts "   - Текущая страница: #{pagy.page}"
puts "   - Всего страниц: #{pagy.pages}"
puts "   - Есть следующая страница: #{pagy.next ? 'Да' : 'Нет'}"
puts "   - Есть предыдущая страница: #{pagy.prev ? 'Да' : 'Нет'}"
puts

puts "4. Рекомендации:"
if books_scope.count <= 2
  puts "   ⚠️  Недостаточно данных для тестирования пагинации!"
  puts "   Запустите: rails db:seed"
else
  puts "   ✅ Достаточно данных для тестирования пагинации"
  puts "   Откройте браузер и перейдите на /books"
end
