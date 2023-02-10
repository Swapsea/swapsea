# frozen_string_literal: true

# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :unsafe_inline, 'https://forecast.io', 'https://www.google-analytics.com', 'https://embed.doorbell.io'
  policy.style_src   :self, :unsafe_inline, 'https://embed.doorbell.io'
end

# Rails.application.config.content_security_policy_nonce_generator = -> request { request.session.id.to_s }
