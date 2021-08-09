# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notices/edit', type: :view do
  before(:each) do
    @notice = assign(:notice, FactoryBot.create(:notice))
  end

  # it "renders the edit notice form" do
  #   render

  #   assert_select "form[action=?][method=?]", notice_path(@notice), "post" do

  #     assert_select "input#notice_title[name=?]", "notice[title]"

  #     assert_select "input#notice_desc[name=?]", "notice[desc]"

  #     assert_select "input#notice_link[name=?]", "notice[link]"

  #     assert_select "input#notice_link_desc[name=?]", "notice[link_desc]"

  #     assert_select "input#notice_image[name=?]", "notice[image]"

  #     assert_select "input#notice_video[name=?]", "notice[video]"

  #     assert_select "input#notice_user_id[name=?]", "notice[user_id]"
  #   end
  # end
end
