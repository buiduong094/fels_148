User.create!(name:  "admin", email: "admin@framgia.com",
  password: "123456", is_admin: true, password_confirmation: "123456")

20.times do |n|
  name = "name - #{n+1}"
  email = "account-#{n+1}@railstutorial.org"
  password = "abc123"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: false)
end

10.times do |category|
  name  = "Category #{category+1}"
  description = "day la mon thu #{category+1}"
  Category.create!(name:  name, description: description)
end

5.times do |category|
  category_id = category+1;
  20.times do |i|
    content = "word #{i+1}"
    word = Word.create!(category_id: category_id, content: content)
    content_answer1 = "answer 1"
    Answer.create!(word_id:  word.id, content: content_answer1, is_correct: true)
    content_answer2 = "answer 2"
    Answer.create!(word_id:  word.id, content: content_answer2, is_correct: false)
    content_answer3 = "answer 3"
    Answer.create!(word_id:  word.id, content: content_answer3, is_correct: false)
    content_answer4 = "answer 4"
    Answer.create!(word_id:  word.id, content: content_answer4, is_correct: false)
  end
end
