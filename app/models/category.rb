# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :person_categories, dependent: nil
  has_many :people, through: :person_categories, dependent: :destroy
  validates :title, presence: true, length: { minimum: 2, maximum: 12 }
  validates :people, presence: true
end
