User.create!(name:  "admin", email: "admin@framgia.com",
  password: "123456", is_admin: true, password_confirmation: "123456")

50.times do |category|
  name  = "Category #{category+1}"
  description = "day la mon thu #{category+1}"
  Category.create!(name:  name, description: description)
end
3.times do |category|
  category_id= category+1;
  6.times do |i|
    content = "word"
    word = Word.create!(category_id:  category_id, content: content)
    content_answer = "answer"
    Answer.create!(word_id:  word.id, content: content_answer, is_correct: true)
    content_answer = "answer"
    Answer.create!(word_id:  word.id, content: content_answer)
    content_answer = "answer"
    Answer.create!(word_id:  word.id, content: content_answer)
  end
end
Lesson.create!(user_id: "1", category_id: "1")

count=1
3.times do |i|
  Result.create!(lesson_id:  1, word_id: i+1, word_answer_id: count)
  count += 3
end
