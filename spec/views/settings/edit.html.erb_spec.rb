# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'settings/edit', type: :view do
  before do
    @setting = assign(:setting, create(:setting))
  end

  it 'renders the edit setting form' do
    render

    assert_select 'form[action=?][method=?]', setting_path(@setting), 'post' do
      assert_select 'input#setting_key[name=?]', 'setting[key]'

      assert_select 'input#setting_value[name=?]', 'setting[value]'
    end
  end
end
