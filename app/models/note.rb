# frozen_string_literal: true

class Note < ApplicationRecord
  # belongs_to :transaction, optional: true
  has_one :owner, class_name: 'Transaction', dependent: nil
  validates :body, presence: true, length: { maximum: 50 }
end
