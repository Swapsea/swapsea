# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patrol_members/index' do
  before do
    @clubs = assign(:clubs, [
                      Club.create!(
                        name: 'Swapsea SLSC',
                        short_name: 'ClubShortName'
                      )
                    ])
    @patrols = assign(:patrols, [
                        Patrol.create!(
                          name: 'PatrolName',
                          club: @clubs.first,
                          need_bbm: 1,
                          need_irbd: 1,
                          need_irbc: 1,
                          need_artc: 1,
                          need_firstaid: 0,
                          need_bronze: 3,
                          need_src: 0
                        )
                      ])
    assign(:patrol_members, [
             PatrolMember.create!(
               user_id: '1',
               default_position: 'DefaultPosition',
               patrol: @patrols.first
             ),
             PatrolMember.create!(
               user_id: '2',
               default_position: 'DefaultPosition',
               patrol: @patrols.first
             )
           ])
  end

  it 'renders a list of patrol_member' do
    allow(view).to receive_messages(will_paginate: nil)
    render
    assert_select 'tr>td', text: '1'.to_s, count: 1
    assert_select 'tr>td', text: '2'.to_s, count: 1
    assert_select 'tr>td', text: 'DefaultPosition', count: 2
    assert_select 'tr>td', text: 'Swapsea SLSC', count: 2
    assert_select 'tr>td', text: 'PatrolName', count: 2
  end
end
