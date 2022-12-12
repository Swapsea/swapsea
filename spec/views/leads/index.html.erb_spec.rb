# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leads/index', type: :view do
  before do
    assign(:leads, [
             Lead.create!(
               name: 'Name',
               email: 'test3@gmail.com',
               organisation: 'Organisation'
             ),
             Lead.create!(
               name: 'Name',
               email: 'test4@gmail.com',
               organisation: 'Organisation'
             )
           ])
  end

  it 'renders a list of leads' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'test3@gmail.com'.to_s, count: 1
    assert_select 'tr>td', text: 'test4@gmail.com'.to_s, count: 1
    assert_select 'tr>td', text: 'Organisation'.to_s, count: 2
  end
end
