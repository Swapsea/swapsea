# frozen_string_literal: true

# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :unsafe_inline, 'https://forecast.io', 'https://www.googletagmanager.com', 'https://www.google.com', 'https://www.gstatic.com', 'https://embed.doorbell.io', 'https://js-agent.newrelic.com', 'https://js.hsforms.net', 'https://js.hs-scripts.com', 'https://js.hs-analytics.net', 'https://js.hscollectedforms.net', 'https://js.hs-banner.com'
  policy.style_src   :self, :unsafe_inline, 'https://embed.doorbell.io', 'https://fonts.googleapis.com'
end

# Rails.application.config.content_security_policy_nonce_generator = -> request { request.session.id.to_s }
