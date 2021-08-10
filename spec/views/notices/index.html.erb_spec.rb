# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notices/index', type: :view do
  before do
    assign(:notices, [
             Notice.create!(
               title: 'Title',
               desc: 'Desc',
               link: 'Link',
               link_desc: 'LinkDesc',
               image: 'Image',
               video: 'Video',
               user_id: '3'
             ),
             Notice.create!(
               title: 'Title',
               desc: 'Desc',
               link: 'Link',
               link_desc: 'LinkDesc',
               image: 'Image',
               video: 'Video',
               user_id: '3'
             )
           ])
  end

  it 'renders a list of notices' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Desc'.to_s, count: 2
    assert_select 'tr>td', text: 'Link'.to_s, count: 2
    assert_select 'tr>td', text: 'LinkDesc'.to_s, count: 2
    assert_select 'tr>td', text: 'Image'.to_s, count: 2
    assert_select 'tr>td', text: 'Video'.to_s, count: 2
    assert_select 'tr>td', text: '3'.to_s, count: 2
  end
end
