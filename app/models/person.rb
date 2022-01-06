# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :user
  has_many :person_categories, dependent: nil
  has_many :categories, through: :person_categories, dependent: :destroy
  validates :name, presence: true, length: { maximum: 16, minimum: 2 }
end
