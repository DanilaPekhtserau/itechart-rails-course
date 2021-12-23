# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.new(email: '123@gmail.com', password: '123456') }
  let(:person) { Person.new(name: 'Person', user: user) }

  it 'can create category with user' do
    category = Category.new(title: 'name', debit: false)
    category.people << person
    expect(category.save).to eq(true)
  end

  it 'can\'t create category without user' do
    category = Category.new(title: 'name')
    expect(category.save).to eq(false)
  end

  it 'can\'t create category with empty title' do
    category = Category.new(title: '')
    category.people << person
    expect(category.save).to eq(false)
  end

  it 'can\'t create category with < 2 chars title' do
    category = Category.new(title: 'u')
    category.people << person
    expect(category.save).to eq(false)
  end

  it 'can\'t create category with > 16 chars title' do
    category = Category.new(title: 'qwertyuiopasdfghjklmbvcxz')
    category.people << person
    expect(category.save).to eq(false)
  end
end
