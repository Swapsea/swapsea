require 'rails_helper'

RSpec.describe 'proficiency_signups/new', type: :view do
  before(:each) do
    assign(:proficiency_signup, ProficiencySignup.new(
      :proficiency_id => '1',
      :user_id => '2'
    ))
  end

  it 'renders the edit proficiency_signup form' do
    render

    assert_select 'form[action=?][method=?]', proficiency_signups_path, 'post' do

      assert_select 'input#proficiency_signup_proficiency_id[name=?]', 'proficiency_signup[proficiency_id]'

      assert_select 'input#proficiency_signup_user_id[name=?]', 'proficiency_signup[user_id]'

    end
  end
end
