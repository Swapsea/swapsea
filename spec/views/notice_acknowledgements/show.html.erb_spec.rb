# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notice_acknowledgements/show' do
  before do
    @notice_acknowledgement = assign(:notice_acknowledgement, create(:notice_acknowledgement))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Notice/)
  end
end
