# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :person_category
  belongs_to :note, optional: true
  before_destroy :destroy_note
  validates :money_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def destroy_note
    note = Note.find_by(id: note_id)
    note.destroy if note.present?
  end
end
