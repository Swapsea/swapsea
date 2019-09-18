# require 'rails_helper'

# RSpec.describe "activities/index.html.erb", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require 'rails_helper'

RSpec.describe "activities/index", type: :view do
  before(:each) do
    assign(:activities, [
      PublicActivity::Activity.create!(
        :trackable_type => "Offer",
        :trackable_id => "1",
        :owner_type => "User",
        :owner_id => "3"
     ),
      PublicActivity::Activity.create!(
        :trackable_type => "Offer",
        :trackable_id => "1",
        :owner_type => "User",
        :owner_id => "3"
     )
    ])
  end

  it "renders a list of activities" do
  end
end
