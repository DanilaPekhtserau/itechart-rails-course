# frozen_string_literal: true

class PersonCategory < ApplicationRecord
  belongs_to :person
  belongs_to :category
end
