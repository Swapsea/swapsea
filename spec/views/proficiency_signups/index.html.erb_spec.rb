require 'rails_helper'

RSpec.describe 'proficiency_signups/index', type: :view do
  before(:each) do
    assign(:proficiency_signups, [
      ProficiencySignup.create!(
        :proficiency_id => '3',
        :user_id => '1'
     ),
      ProficiencySignup.create!(
        :proficiency_id => '3',
        :user_id => '1'
     )
    ])
  end

  it 'renders a list of proficiency_signups' do
    render
    assert_select 'tr>td', :text => '3'.to_s, :count => 2
    assert_select 'tr>td', :text => '1'.to_s, :count => 2
  end
end
