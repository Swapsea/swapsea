require 'rails_helper'

RSpec.describe "patrol_members/edit", type: :view do
  before(:each) do
    @patrol_member = assign(:patrol_member, FactoryBot.create(:patrol_member))
  end

  # it "renders the edit patrol_member form" do
  #   render

  #   assert_select "form[action=?][method=?]", patrol_member_path(@patrol_member), "post" do

  #     assert_select "input#patrol_member_user_id[name=?]", "patrol_member[user_id]"

  #     assert_select "input#patrol_member_default_position[name=?]", "patrol_member[default_position]"

  #     assert_select "input#patrol_member_organisation[name=?]", "patrol_member[organisation]"

  #     assert_select "input#patrol_member_patrol_name[name=?]", "patrol_member[patrol_name]"
  #   end
  # end
end
