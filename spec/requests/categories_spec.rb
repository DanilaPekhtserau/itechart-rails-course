# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { User.create(email: '123@gmail.com', password: '123456') }
  before do
    post user_session_path \
      "user[email]"    => user.email,
      "user[password]" => user.password
  end

  it 'should process request without 2 valid dates' do
    category = Category.new(title: 'category', debit:false)
    category.people << user.people.first
    category.save
    get '/categories/'+category.id.to_s+'/details'
    post categories_details_path
    expect(response.body).to include('Укажите начальную и конечную дату')
  end
end
