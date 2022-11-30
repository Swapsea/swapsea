# frozen_string_literal: true

# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, 'unsafe-inline', 'https://forecast.io', 'https://www.google-analytics.com'
  policy.style_src   :self, 'unsafe-inline'
end

# Rails.application.config.content_security_policy_nonce_generator = -> request { request.session.id.to_s }
