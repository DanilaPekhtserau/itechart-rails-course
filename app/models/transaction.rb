class Transaction < ApplicationRecord
  belongs_to :person_category
  validates :money_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
