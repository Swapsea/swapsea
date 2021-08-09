# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'clubs/edit', type: :view do
  before(:each) do
    @club = assign(:club, FactoryBot.create(:club))
  end

  it 'renders the edit club form' do
    render

    assert_select 'form[action=?][method=?]', club_path(@club), 'post' do
      assert_select 'input#club_name[name=?]', 'club[name]'

      assert_select 'input#club_short_name[name=?]', 'club[short_name]'
    end
  end
end
