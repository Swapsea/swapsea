# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notice_acknowledgements/new', type: :view do
  before do
    assign(:notice_acknowledgement, NoticeAcknowledgement.new(
                                      notice_id: '1',
                                      user_id: '2'
                                    ))
  end

  it 'renders the edit notice_acknowledgement form' do
    render

    assert_select 'form[action=?][method=?]', notice_acknowledgements_path, 'post' do
      assert_select 'input#notice_acknowledgement_notice_id[name=?]', 'notice_acknowledgement[notice_id]'

      assert_select 'input#notice_acknowledgement_user_id[name=?]', 'notice_acknowledgement[user_id]'
    end
  end
end
