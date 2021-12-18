# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:user) { User.new(email: '123@gmail.com', password: '123456') }

  it 'can create person with user' do
    person = Person.new(name: 'name')
    person.user = user
    expect(person.save).to eq(true)
  end

  it 'can\'t create person without user' do
    person = Person.new(name: 'name')
    expect(person.save).to eq(false)
  end

  it 'can\'t create person with empty name' do
    person = Person.new(name: '')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'can\'t create person with < 2 chars name' do
    person = Person.new(name: 'u')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'can\'t create person with > 16 chars name' do
    person = Person.new(name: 'qwertyuiopasdfghjklmbvcxz')
    person.user = user
    expect(person.save).to eq(false)
  end
end
