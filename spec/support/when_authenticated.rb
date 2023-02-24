# frozen_string_literal: true

module WhenAuthenticated
  def authenticate_user(user)
    visit '/users/sign_in'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'swapsea'

    click_button 'Login'
  end
end

RSpec.configure do |config|
  config.include WhenAuthenticated, type: :feature
end
