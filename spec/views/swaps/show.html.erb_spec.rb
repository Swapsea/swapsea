require 'rails_helper'

RSpec.describe "swaps/show", type: :view do

  let(:user) {FactoryBot.create(:user) }
    before(:each) do
		@swap = assign(:swap, Swap.create!(
			:roster_id => "1",
      :user_id => user.id,
      :on_off_patrol => true
		))
	end

end