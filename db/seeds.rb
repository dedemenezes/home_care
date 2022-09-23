# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'
require 'nokogiri'

User.destroy_all
Game.destroy_all
puts 'seeding users...'

url = 'https://randomuser.me/api/?nat=br&results=10'
data = JSON.parse(URI.open(url).read)
data['results'].each_with_index do |random_user, index|
  user = User.create!(
    email: random_user['email'],
    password: 123456,
    phone_number: "+55#{random_user['phone'].split(' ').last}#{rand(9)}",
    country: random_user['location']['country'],
    role: index.even? ? 'doctor' : 'patient',
    city: random_user['location']['city'],
    street: random_user['location']['street']['name'],
    street_number: random_user['location']['street']['number'],
    state: random_user['location']['state'],
    first_name: random_user['name']['first'],
    last_name: random_user['name']['last'],
    image_url: random_user['picture']['large']
    )
  p user
end


html = File.open(Rails.root.join('./Multiple-Choice-Questions-of-Biology-with-Answers-Ilmi-Hub.html')).read
doc = Nokogiri::HTML(html)
# p doc
# Array.from(document.querySelectorAll('p')).map(e => e.innerText.match(/^\(\w*\)/)).filter(e => e !== null)
questions = []
answers = []

doc.search('p').each do |element|
  paragraph = element.text
  questions << paragraph if paragraph.match?(/^\d/)
  answers << paragraph if paragraph.match?(/^\(\w*\)/)
end

correct_answers = []
doc.search('div strong').each do |element|
  correct_answers << element.text if element.text.match?(/^\(\w*\)/)
end

quiz = questions.map.with_index do |question, index|
  {
    question: question,
    options: answers[index],
    answer: correct_answers[index]
  }
end
quiz.each do |question|
  question[:options] = question[:options][...-12].split('(')[1..].map { |option| [option[0], option[3..].strip] }.to_h
  question[:answer] = { question[:answer][1] => question[:answer][4..].strip }
end
# quiz = Hash[questions.zip(answers)]
# p quiz
trivia = Game.create! name: 'Trivia', icon_name: 'dna'
quiz.each do |question|
  sanitized_content = question[:question].gsub(/\d{1,2}\. /,'')
  sanitized_number = question[:question].slice(/\d{1,2}/)
  q = Question.create!(
    game: trivia,
    content: sanitized_content,
    usual_number: sanitized_number,
    answer: question[:answer].to_json
  )
  p q.to_s
  question[:options].each do |key, value|
    Option.create question: q, content: value, letter: key
  end
end
