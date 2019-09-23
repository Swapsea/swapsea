require 'rails_helper'

RSpec.describe "notice_acknowledgements/edit", type: :view do
  before(:each) do
    @notice_acknowledgement = assign(:notice_acknowledgement, FactoryBot.create(:notice_acknowledgement))
  end

  it "renders the edit notice_acknowledgement form" do
    render

    assert_select "form[action=?][method=?]", notice_acknowledgement_path(@notice_acknowledgement), "post" do

      assert_select "input#notice_acknowledgement_notice_id[name=?]", "notice_acknowledgement[notice_id]"

      assert_select "input#notice_acknowledgement_user_id[name=?]", "notice_acknowledgement[user_id]"

    end
  end
end
