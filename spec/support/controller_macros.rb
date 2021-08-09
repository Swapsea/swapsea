# frozen_string_literal: true

# spec/support/controller_macros.rb

module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.save
      sign_in user
    end
  end
end
