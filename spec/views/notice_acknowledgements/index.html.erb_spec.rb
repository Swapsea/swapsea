require 'rails_helper'

RSpec.describe "notice_acknowledgements/index", type: :view do
  before(:each) do
    assign(:notice_acknowledgements, [
      NoticeAcknowledgement.create!(
        :notice_id => "3",
        :user_id => "1"
     ),
      NoticeAcknowledgement.create!(
        :notice_id => "3",
        :user_id => "1"
     )
    ])
  end

  it "renders a list of notice_acknowledgements" do
    render
    assert_select "tr>td", :text => "3".to_s, :count => 2
    assert_select "tr>td", :text => "1".to_s, :count => 2
  end
end
