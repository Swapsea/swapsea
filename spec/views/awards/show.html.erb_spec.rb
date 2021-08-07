require 'rails_helper'

RSpec.describe "awards/show", type: :view do

  before(:each) do
		@award = assign(:award, Award.create!(
			:award_number => "AwardNumber",
        :award_name => "AwardName",
        :user_id => "1"
		))
	end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/AwardNumber/)
    expect(rendered).to match(/AwardName/)
    expect(rendered).to match(/1/)
  end
end
