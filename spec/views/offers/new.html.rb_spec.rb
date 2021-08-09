# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offers/new', type: :view do
  before(:each) do
    assign(:offer, Offer.new(
                     request_id: '1',
                     user_id: '2',
                     comment: 'MyString',
                     status: 'MyString',
                     mobile: 'MyString'
                   ))
  end

  it 'renders the edit offer form' do
    render

    assert_select 'form[action=?][method=?]', offers_path, 'post' do
      assert_select 'input#offer_request_id[name=?]', 'offer[request_id]'

      assert_select 'input#offer_user_id[name=?]', 'offer[user_id]'

      assert_select 'input#offer_comment[name=?]', 'offer[comment]'

      assert_select 'input#offer_status[name=?]', 'offer[status]'

      assert_select 'input#offer_mobile[name=?]', 'offer[mobile]'
    end
  end
end
