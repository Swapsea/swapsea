# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patrol_members/show', type: :view do
  before(:each) do
    @patrol_member = assign(:patrol_member, FactoryBot.create(:patrol_member))
  end

  it 'renders attributes in <p>' do
    render
  end
end
