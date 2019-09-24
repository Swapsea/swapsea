require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        :key => "1",
        :value => "Value",
     ),
      Setting.create!(
        :key => "1",
        :value => "Value",
     )
    ])
  end

  it "renders a list of setting" do
    render
    assert_select "tr>td", :text => "1".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
