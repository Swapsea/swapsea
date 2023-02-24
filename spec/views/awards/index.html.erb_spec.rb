# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'awards/index' do
  let(:user) { create(:user) }

  before do
    assign(:awards, [
             Award.create!(
               award_number: 'AwardNumber1',
               award_name: 'AwardName',
               user_id: user.id
             )
           ])
  end

  it 'renders a list of awards' do
    render
    assert_select 'tr>td', text: 'AwardNumber1'.to_s, count: 1
    assert_select 'tr>td', text: 'AwardName'.to_s, count: 1
    assert_select 'tr>td', text: user.id.to_s, count: 1
  end
end
