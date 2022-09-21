require 'open-uri'
require 'nokogiri'

html = File.open('./Multiple-Choice-Questions-of-Biology-with-Answers-Ilmi-Hub.html').read
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
p quiz
  # question_data = question.match /(\d*)\. (.*)/
  # quiz["question_#{question_data[0]}"] = {question: question_data[1] }
