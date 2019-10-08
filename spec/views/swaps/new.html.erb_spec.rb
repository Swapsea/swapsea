require 'rails_helper'

RSpec.describe "swaps/new", type: :view do
  before(:each) do
    assign(:swap, Swap.new(
      :roster_id => "1",
      :user_id => "2",
      :on_off_patrol => true
    ))
  end

  it "renders the edit swap form" do
    render

    assert_select "form[action=?][method=?]", swaps_path, "post" do

      assert_select "input#swap_roster_id[name=?]", "swap[roster_id]"

      assert_select "input#swap_user_id[name=?]", "swap[user_id]"

      assert_select "input#swap_on_off_patrol[name=?]", "swap[on_off_patrol]"

    end
  end
end