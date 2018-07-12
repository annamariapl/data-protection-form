class Agreement < ApplicationRecord
  has_many :agreement_answers
  has_many :answers, through: :agreement_answers
end
