# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    WebMock.disable_net_connect!(allow_localhost: true, allow: 'chromedriver.storage.googleapis.com')
  end
end
