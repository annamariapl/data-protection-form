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
    unter_titel: "Gewährleistung, dass personenbezogene Daten im System nur in einer Weise gespeichert werden, die Dritten die Zuordnung zum Betroffenen nicht ermöglicht."
    },
  {
    title: "Zutrittskontrolle",
    unter_titel: "Verwehrung des Zugangs zu Verarbeitungsanlagen, mit denen die Verarbeitung durchgeführt wird, für Unbefugte."
    },
  {
    title: "Zugangskontorolle",
    unter_titel: "Verhinderung des unbefugten Lesens, Kopierens, Veränderns oder Löschens von Datenträgern."
    },
  {
    title: "Zugriffskontrolle",
    unter_titel: "Folgende implementierte Maßnahmen stellen sicher, dass Unbefugte keinen Zugriff auf personenbezogene Daten haben und dass personenbezogene Daten bei der Verarbeitung, Nutzung und nach der Speicherung nicht unbefugt gelesen, kopiert, verändert oder entfernt werden können."
    },
  {
    title: "Übertragungskontrolle",
    unter_titel: "Gewährleistung, dass überprüft und festgestellt werden kann, an welche Stellen personenbezogene Daten mit Hilfe von Einrichtungen zur Datenübertragung übermittelt oder zur Verfügung gestellt wurden oder werden können."
    },
  {
    title: "Transportkontrolle",
    unter_titel: "Gewährleistung, dass bei der Übermittlung personenbezogener Daten sowie beim Transport von Datenträgern die Vertraulichkeit und Integrität der Daten geschützt wird."
  },
  {
    title: "Eingabekontrolle",
    unter_titel: "Gewährleistung, dass nachträglich überprüft und festgestellt werden kann, welche personenbezogenen Daten zu welcher Zeit und von wem in automatisierte Verarbeitungssysteme eingegeben oder verändert worden sind."
    },
     {
    title: "Datenintegrität",
    unter_titel: "Gewährleistung, dass gespeicherte personenbezogene Daten nicht durch Fehlfunktionen des Systems beschädigt werden können."
    },
     {
    title: "Auftragskontrolle",
    unter_titel: "Gewährleistung, dass personenbezogene Daten, die im Auftrag verarbeitet werden, nur entsprechend den Weisungen verarbeitet werden können."
    },
     {
    title: "Verfügbarkeit",
    unter_titel: "Gewährleistung, dass personenbezogene Daten gegen Zerstörung oder Verlust geschützt sind."
    },
     {
    title: "Belastbarkeit",
    unter_titel: "Gewährleistung, dass alle Funktionen des Systems zur Verfügung stehen und auftretende Fehlfunktionen gemeldet werden."
    },
     {
    title: "Wiederherstellbarkeit",
    unter_titel: "Gewährleistung, dass eingesetzte Systeme im Störungsfall wiederhergestellt werden können."
    },
     {
    title: "Trennbarkeit",
    unter_titel: "Gewährleistung, dass zu unterschiedlichen Zwecken erhobene, personenbezogene Daten getrennt verarbeitet werden können."
    },
     {
    title: "Datenschutz-Management und Organisation",
    unter_titel: "Darstellung des Verfahrens zur regelmäßigen Überprüfung, Bewertung und Evaluierung der Wirksamkeit der technischen und organisatorischen Maßnahmen und zur Gewährleistung einer den datenschutzrechtlichen Grundanforderungen genügenden Organisation."
    },
     {
    title: "Datenschutz-Management und Organisation",
    unter_titel: "Die default Einstellungen sind sowohl bei den standardisierten Voreinstellungen von Systemen und Apps als auch bei der Einrichtung der Datenverarbeitungsverfahren zu berücksichtigen. In dieser Phase werden Funktionen und Rechte konkret konfiguriert, wird im Hinblick auf Datenminimierung die Zulässigkeit bzw. Unzulässigkeit bestimmter Eingaben bzw. von Eingabemöglichkeiten (z.B. von Freitexten) festgelegt und über die Verfügbarkeit von Nutzungsfunktionen entschieden (z.B. hinsichtlich des Umfangs der Verarbeitung). Ebenso werden die Art und der Umfang des Personenbezugs bzw. der Anonymisierung (z.B. bei Selektions-, Export- und Auswertungsfunktionen, die festgelegt und voreingestellt oder frei gestaltbar zur Verfügung gestellt werden können) oder die Verfügbarkeit von bestimmten Verarbeitungsfunktionen, Protokollierungen etc. festgelegt."
    },
     {
    title: "Datenschutzfreundliche Voreinstellungen (Art. 25 Abs. 2 DSGVO)",
    unter_titel: "Folgende Maßnahmen sollen gewährleisten, dass im Fall von Datenschutzverstößen Meldeprozesse ausgelöst werden."
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
