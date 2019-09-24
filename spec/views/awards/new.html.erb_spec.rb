require 'rails_helper'

RSpec.describe "awards/new", type: :view do
  before(:each) do
    assign(:award, Award.new(
       :award_number => "AwardNumber",
        :award_name => "AwardName",
        :user_id => "1"
    ))
  end

  it "renders new award form" do
    render

    assert_select "form[action=?][method=?]", awards_path, "post" do

      assert_select "input#award_award_name[name=?]", "award[award_name]"

      assert_select "input#award_award_number[name=?]", "award[award_number]"

      assert_select "input#award_user_id[name=?]", "award[user_id]"
    end
  end
end
