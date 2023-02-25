# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leads/show' do
  before do
    @lead = assign(:lead, create(:lead))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Organisation/)
  end
end
