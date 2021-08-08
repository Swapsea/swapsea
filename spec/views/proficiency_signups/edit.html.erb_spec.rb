require 'rails_helper'

RSpec.describe 'proficiency_signups/edit', type: :view do
  before(:each) do
    @proficiency_signup = assign(:proficiency_signup, FactoryBot.create(:proficiency_signup))
  end

  it 'renders the edit proficiency_signup form' do
    render

    assert_select 'form[action=?][method=?]', proficiency_signup_path(@proficiency_signup), 'post' do

      assert_select 'input#proficiency_signup_proficiency_id[name=?]', 'proficiency_signup[proficiency_id]'

      assert_select 'input#proficiency_signup_user_id[name=?]', 'proficiency_signup[user_id]'

    end
  end
end
