require 'rails_helper'

RSpec.describe Note, type: :model do


  it 'shoudn\'t create note with empty body' do
    note = Note.new(body: '')
    expect(note.save).to eq(false)
  end

  it 'cshoudn\'t create note with > 50 chars name' do
    note = Note.new(body: 'qwertyuiopasdfghjklmbvcxzertmuuhtvmehurimvthurmvhutivtrhumeivrtehuimvietrhvthmeruimvehuitrmvhtueirtvmhueirtvhihmuitvetvhmiuhimutevrhmtuvehtuimvetvhiuetveiuhtevitveihmuteviuhetviuhmetvhetvhiutevhiumetvtevihuetvihtvei')
    expect(note.save).to eq(false)
  end
end
