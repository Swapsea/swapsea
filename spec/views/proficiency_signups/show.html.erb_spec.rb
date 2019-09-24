require 'rails_helper'

RSpec.describe "proficiency_signups/show", type: :view do
  before(:each) do
    @proficiency_signup = assign(:proficiency_signup, FactoryBot.create(:proficiency_signup))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/3/)
  end
end
