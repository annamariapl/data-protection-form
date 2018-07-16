class Question < ApplicationRecord
	belongs_to :agreement_template
  belongs_to :chapter
	has_many :answers
end
