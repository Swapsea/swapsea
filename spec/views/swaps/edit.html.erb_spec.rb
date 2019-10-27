require 'rails_helper'

RSpec.describe "swaps/edit", type: :view do
  before(:each) do
    @swap = assign(:swap, FactoryBot.create(:swap))
  end

  it "renders the edit swap form" do
    render

    assert_select "form[action=?][method=?]", swap_path(@swap), "post" do

      assert_select "input#swap_roster_id[name=?]", "swap[roster_id]"

      assert_select "input#swap_user_id[name=?]", "swap[user_id]"

      assert_select "input#swap_on_off_patrol[name=?]", "swap[on_off_patrol]"

    end
  end
end