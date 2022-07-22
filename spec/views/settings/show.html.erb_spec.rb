# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'settings/show', type: :view do
  before do
    @setting = assign(:setting, create(:setting))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
  end
end
