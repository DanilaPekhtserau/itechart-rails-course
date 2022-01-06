require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(email: 'mail@gmail.com', password: 'pass') }
  let(:person) { Person.create(name:'qewqe', user: user) }
  let(:category) { Category.create(title: 'cat', debit:false) }
  before do
    category.people<< person
    category.save
  end
  it 'should create new Transaction' do
    t = Transaction.create(money_amount: 100, note_id: nil, important: false, person_category: PersonCategory.first)
    t.save
    expect(t.save).to eq(true)
  end
  it 'should not create new Transaction without PersonCategory' do
    t = Transaction.create(money_amount: 100, note_id: nil, important: false)
    t.save
    expect(t.save).to eq(false)
  end
  it 'should not create new Transaction without money_amount' do
    t = Transaction.create( note_id: nil, important: false, person_category: PersonCategory.first)
    t.save
    expect(t.save).to eq(false)
  end
  it 'should not create new Transaction with incorrect money_amount' do
    t = Transaction.create(money_amount: -1, note_id: nil, important: false, person_category: PersonCategory.first)
    t.save
    expect(t.save).to eq(false)
  end
end
