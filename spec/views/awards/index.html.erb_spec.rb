require 'rails_helper'

RSpec.describe "awards/index", type: :view do

  let(:user) {FactoryBot.create(:user) }
 
  before(:each) do
    assign(:awards, [
      Award.create!(
        :award_number => "AwardNumber",
        :award_name => "AwardName",
        :user_id => user.id
     )
    ])
  end

  it "renders a list of awards" do
    render
    assert_select "tr>td", :text => "AwardNumber".to_s, :count => 1
    assert_select "tr>td", :text => "AwardName".to_s, :count => 1
    assert_select "tr>td", :text => user.id.to_s, :count => 1
  end
end
