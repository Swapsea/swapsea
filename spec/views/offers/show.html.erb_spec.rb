# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offers/show', type: :view do
  before do
    @offer = assign(:offer, create(:offer))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Mobile/)
  end
end
