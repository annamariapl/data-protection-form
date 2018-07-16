class Question < ApplicationRecord
	belongs_to :agreement_template
	has_many :answers
end
