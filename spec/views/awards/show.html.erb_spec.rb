require 'rails_helper'

RSpec.describe "awards/show", type: :view do
  before(:each) do
    @award = assign(:award, FactoryBot.create(:award))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1000/)
    expect(rendered).to match(/name/)
    expect(rendered).to match(/1/)
  end
end
