# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patrol_members/index', type: :view do
  before do
    assign(:patrol_members, [
             PatrolMember.create!(
               user_id: '1',
               default_position: 'DefaultPosition',
               patrol.name: 'PatrolName'
             ),
             PatrolMember.create!(
               user_id: '1',
               default_position: 'DefaultPosition',
               patrol.name: 'PatrolName'
             )
           ])
  end

  it 'renders a list of patrol_member' do
    allow(view).to receive_messages(will_paginate: nil)
    render
    assert_select 'tr>td', text: '1'.to_s, count: 2
    assert_select 'tr>td', text: 'DefaultPosition'.to_s, count: 2
    assert_select 'tr>td', text: 'Organisation'.to_s, count: 2
    assert_select 'tr>td', text: 'PatrolName'.to_s, count: 2
  end
end
