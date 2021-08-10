# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/index' do
  it 'displays all the text' do
    render

    expect(rendered).to match(/Index/)
    expect(rendered).to match(/Admin index page/)
  end
end
