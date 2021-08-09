# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'settings/new', type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      key: '1',
      value: 'Value',
    ))
  end

  it 'renders the edit setting form' do
    render

    assert_select 'form[action=?][method=?]', settings_path, 'post' do

      assert_select 'input#setting_key[name=?]', 'setting[key]'

      assert_select 'input#setting_value[name=?]', 'setting[value]'

    end
  end
end
