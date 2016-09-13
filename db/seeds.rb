User.create!(name:  "admin", email: "admin@framgia.com",
  password: "123456", is_admin: true, password_confirmation: "123456")

20.times do |n|
  name  = Faker::Name.name
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
  description = "Here is the description of the #{category+1} course"
  Category.create!(name:  name, description: description)
end

5.times do |category|
  category_id = category+1;
  20.times do |i|
    content = "This is the content of the question #{i+1} of No. #{category_id}"
    word = Word.create!(category_id: category_id, content: content)
    content_answer1 = "This is the content of answers 1"
    Answer.create!(word_id:  word.id, content: content_answer1, is_correct: true)
    content_answer2 = "This is the content of answers 2"
    Answer.create!(word_id:  word.id, content: content_answer2, is_correct: false)
    content_answer3 = "This is the content of answers 3"
    Answer.create!(word_id:  word.id, content: content_answer3, is_correct: false)
    content_answer4 = "This is the content of answers 4"
    Answer.create!(word_id:  word.id, content: content_answer4, is_correct: false)
  end
end

users = User.all
user  = users.first
following = users[2..15]
followers = users[3..12]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
