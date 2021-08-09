# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'routing' do

    it 'routes to #root' do
      expect(get: '/').to route_to('home#index')
    end

    it 'routes to #thanks' do
      expect(get: '/thanks').to route_to('home#thanks')
    end

    it 'routes to #privacy_policy' do
      expect(get: '/privacy-policy').to route_to('home#privacy_policy')
    end

    it 'routes to #terms_of_use' do
      expect(get: '/terms-of-use').to route_to('home#terms_of_use')
    end

     it 'routes to #about_us' do
      expect(get: '/about').to route_to('home#about_us')
    end
  end
end
