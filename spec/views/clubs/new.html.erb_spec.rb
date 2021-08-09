# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'clubs/new', type: :view do
  before(:each) do
    assign(:club, Club.new(
      :name => 'Name',
      :short_name => 'ShortName'
    ))
  end

  it 'renders new club form' do
    render

    assert_select 'form[action=?][method=?]', clubs_path, 'post' do

      assert_select 'input#club_name[name=?]', 'club[name]'

      assert_select 'input#club_short_name[name=?]', 'club[short_name]'
    end
  end
end
