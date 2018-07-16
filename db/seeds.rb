=begin

at = AgreementTemplate.create(title: "hello")

5.times do |i|
  q = Question.create(agreement_template: at, title: "Question #{i}")
  5.times do |i|
    a = Answer.create(question: q, title: "Answer #{i}", sentence: "Sentence #{i}")
  end
end

=end

require "open-uri"
require "yaml"


chapters_attributes = [
  {
    title: "Verschlüsselung und Pseudonymisierung personenbezogener Daten",
    # unter_titel: "Gewärleistung, dass personenbezogene Daten im System nur in einer Weise gespeichert werden, die Dritten die Zuordnung zum Betroffenen nicht ermöglicht"
    },
  {
    title: "Vertrauligkeit und Integrität"
    },
  {
    title: "Zutrittskontolle"
    },
  {
    title: "Zugangskontorolle"
    },
  {
    title: "Zugriffskontrolle"
    },
  {
    title: "Übertragungskontrolle"
    },
  {
    title: "Transportkontrolle"
  }
]

template = AgreementTemplate.create(title: "TOM")
seed_file = "db/seed_file.yml"
sample = YAML.load(open(seed_file).read)

puts "Creating chapters..."
chapter = Chapter.create!(chapters_attributes)
puts "Chapters created (from an array in --- seed.rb)"

puts 'Creating questions...'
# questions = {}
sample["questions"].each do |question|
	q = Question.create! question.slice("title", "chapter_id").merge(agreement_template: template)
	puts 'Creating answers'
	sample["answers"].each do |answer|
		if q.id == answer.first.second
			Answer.create! answer.slice("title", "sentence", "pointing").merge(question: q)
		end
	end
end

puts 'Finished!'



=begin


puts 'Creating questions...'
# questions = {}
sample["questions"].each do |question|
	q = Question.create! question.slice("title").merge(agreement_template: template)
	puts 'Creating answers'
	sample["answers"].each do |answer|
		# puts "#{q.id}"
		puts "#{answer.first.second}" #question_id
		puts "#{sample["answers"].first}"
		puts "#{sample["answers"].second}"
		Answer.create! answer.slice("title", "sentence").merge(question: q)
	end
end

puts 'Finished!'

=end




=begin
puts 'Creating questions...'
# questions = {}
sample["questions"].each do |question|
	q = Question.create! question.slice("title").merge(agreement_template: template)
	puts 'Creating answers'
	sample["answers"].each do |answer|
		if q.id == answer.first.second
			Answer.create! answer.slice("title", "sentence").merge(question: q)
		end
	end
end

puts 'Finished!'
=end
