User.create!(name:  "admin", email: "admin@framgia.com",
  password: "123456", is_admin: true, password_confirmation: "123456")

50.times do |category|
  name  = "mon #{category+1}"
  description = "day la mon thu #{category+1}"
  Category.create!(name:  name, description: description)
end
3.times do |category|
  category_id= category+1;
  50.times do |i|
  content = "tu thu #{i+1}, #{category+1}"
    Word.create!(category_id:  category_id, content: content)
  end
end
