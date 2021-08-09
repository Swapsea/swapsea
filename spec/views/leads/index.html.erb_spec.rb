# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'leads/index', type: :view do
  before(:each) do
    assign(:leads, [
      Lead.create!(
        :name => 'Name',
        :email => 'test1@gmail.com',
        :organisation => 'Organisation'
     ),
       Lead.create!(
        :name => 'Name',
        :email => 'test2@gmail.com',
        :organisation => 'Organisation'
     )
    ])
  end

  it 'renders a list of leads' do
    render
    assert_select 'tr>td', :text => 'Name'.to_s, :count => 2
    assert_select 'tr>td', :text => 'test1@gmail.com'.to_s, :count => 1
    assert_select 'tr>td', :text => 'test2@gmail.com'.to_s, :count => 1
    assert_select 'tr>td', :text => 'Organisation'.to_s, :count => 2
  end
end
