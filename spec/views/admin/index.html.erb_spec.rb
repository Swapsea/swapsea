# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/index' do
  it 'displays the admin home text' do
    render

    expect(rendered).to match(/Administrator Use Only/)
  end
end
