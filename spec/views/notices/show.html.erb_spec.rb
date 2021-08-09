# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notices/show', type: :view do
  before do
    @notice = assign(:notice, FactoryBot.create(:notice))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Desc/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Video/)
    expect(rendered).to match(/3/)
  end
end
