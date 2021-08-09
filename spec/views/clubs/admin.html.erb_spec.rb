# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'clubs/admin', type: :view do
  before(:each) do
    assign(:clubs, [
      Club.create!(
        :name => 'Name',
        :short_name => 'ShortName'
     ),
      Club.create!(
        :name => 'Name',
        :short_name => 'ShortName'
     )
    ])
  end

  it 'renders a list of clubs' do
    render
    assert_select 'tr>td', :text => 'Name'.to_s, :count => 2
    assert_select 'tr>td', :text => 'ShortName'.to_s, :count => 2
  end
end
