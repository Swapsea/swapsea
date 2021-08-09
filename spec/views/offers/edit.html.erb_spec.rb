# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offers/edit', type: :view do
  before do
    @offer = assign(:offer, FactoryBot.create(:offer))
  end

  it 'renders the edit offer form' do
    render

    assert_select 'form[action=?][method=?]', offer_path(@offer), 'post' do
      assert_select 'input#offer_request_id[name=?]', 'offer[request_id]'

      assert_select 'input#offer_user_id[name=?]', 'offer[user_id]'

      assert_select 'input#offer_comment[name=?]', 'offer[comment]'

      assert_select 'input#offer_status[name=?]', 'offer[status]'

      assert_select 'input#offer_mobile[name=?]', 'offer[mobile]'
    end
  end
end
