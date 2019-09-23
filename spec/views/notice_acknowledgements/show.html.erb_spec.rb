require 'rails_helper'

RSpec.describe "notice_acknowledgements/show", type: :view do
  before(:each) do
    @notice_acknowledgement = assign(:notice_acknowledgement, FactoryBot.create(:notice_acknowledgement))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Notice/)
  end
end
