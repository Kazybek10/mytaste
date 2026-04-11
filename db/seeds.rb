User.find_or_create_by!(email: 'admin@admin.com') do |u|
  u.password = 'secret123'
  u.password_confirmation = 'secret123'
end
