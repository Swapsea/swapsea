# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'offers/index', type: :view do
  before(:each) do
    assign(:offers, [
      Offer.create!(
        request_id: '3',
        user_id: '1',
        comment: 'Comment',
        status: 'Status',
        mobile: 'Mobile',
     ),
      Offer.create!(
        request_id: '3',
        user_id: '1',
        comment: 'Comment',
        status: 'Status',
        mobile: 'Mobile',
     )
    ])
  end

  it 'renders a list of offers' do
    render
    assert_select 'tr>td', text: '3'.to_s, count: 2
    assert_select 'tr>td', text: '1'.to_s, count: 2
    assert_select 'tr>td', text: 'Comment'.to_s, count: 2
    assert_select 'tr>td', text: 'Status'.to_s, count: 2
    assert_select 'tr>td', text: 'Mobile'.to_s, count: 2
  end
end
