# frozen_string_literal: true
require 'test_helper'

class EmailsControllerTest < ActionController::TestCase
  test 'that welcome sends' do

   u = User.find_by(email: 'mark@swapsea.com.au')
   email = SwapseaMailer.welcome_email(u)

   # Send the email, then test that it got queued
   assert_emails 1 do
     email.deliver
   end


   # Test the body of the sent email contains what we expect it to
   assert_equal ['Swapsea <help@swapsea.com.au>'], email.from
   assert_equal ['mark@swapsea.com.au'], email.to
   assert_equal 'Activate your Swapsea account for 2021/22', email.subject

 end
end
