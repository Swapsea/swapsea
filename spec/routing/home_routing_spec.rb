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

    it 'routes to #faq' do
      expect(get: '/faq').to route_to('home#faq')
    end

    it 'routes to #setup' do
      expect(get: '/setup').to route_to('home#setup')
    end

    it 'routes to #contact_us' do
    expect(get: '/contact-us').to route_to('home#contact_us')
  end
  end
end
