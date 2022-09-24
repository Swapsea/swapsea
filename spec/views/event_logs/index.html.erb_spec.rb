# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'event_logs/index', type: :view do
  before do
    assign(:event_logs, [
             EventLog.create!(
               subject: 'Subject',
               desc: 'Desc'
             ),
             EventLog.create!(
               subject: 'Subject',
               desc: 'Desc'
             )
           ])
  end

  it 'renders a list of event_logs' do
    allow(view).to receive_messages(will_paginate: nil)
    render
    assert_select 'tr>td', text: 'Subject'.to_s, count: 2
    assert_select 'tr>td', text: 'Desc'.to_s, count: 2
  end
end
