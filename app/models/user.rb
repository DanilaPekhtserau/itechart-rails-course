# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :people, dependent: :destroy
  after_create :create_person

  def create_person
    Person.create(user: self, name: 'My first person')
  end
end
