# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'awards/edit' do
  before do
    @award = create(:award)
  end

  it 'renders the edit award form' do
    render

    assert_select 'form[action=?][method=?]', award_path(@award), 'post' do
      assert_select 'input#award_award_name[name=?]', 'award[award_name]'

      assert_select 'input#award_award_number[name=?]', 'award[award_number]'

      assert_select 'input#award_user_id[name=?]', 'award[user_id]'
    end
  end
end
