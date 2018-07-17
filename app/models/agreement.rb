class Agreement < ApplicationRecord
	has_many :agreement_answers
	has_many :answers, through: :agreement_answers
  # accepts_nested_attributes_for :agreement_answers, :allow_destroy => true
end
