
at = AgreementTemplate.create(title: "hello")

5.times do |i|
  q = Question.create(agreement_template: at, title: "Question #{i}")
  5.times do |i|
    a = Answer.create(question: q, title: "Answer #{i}", sentence: "Sentence #{i}")
  end
end
