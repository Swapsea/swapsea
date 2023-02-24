# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'activities/index' do
  before do
    assign(:activities, [
             PublicActivity::Activity.create!(
               trackable_type: 'Offer',
               trackable_id: '1',
               owner_type: 'User',
               owner_id: '3'
             ),
             PublicActivity::Activity.create!(
               trackable_type: 'Offer',
               trackable_id: '1',
               owner_type: 'User',
               owner_id: '3'
             )
           ])
  end

  it 'renders a list of activities' do
  end
end
