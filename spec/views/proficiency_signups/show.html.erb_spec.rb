# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'proficiency_signups/show', type: :view do
  before(:each) do
    @proficiency_signup = assign(:proficiency_signup, ProficiencySignup.create!(
                                                        proficiency_id: '3',
                                                        user_id: '1'
                                                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/3/)
    expect(rendered).to match(/1/)
  end
end
