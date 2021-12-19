# frozen_string_literal: true

class Person < ApplicationRecord
  validates :name, presence: true, length: { maximum: 16, minimum: 2 }
  belongs_to :user
end
