# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leads/show', type: :view do
  before(:each) do
    @lead = assign(:lead, FactoryBot.create(:lead))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Organisation/)
  end
end
