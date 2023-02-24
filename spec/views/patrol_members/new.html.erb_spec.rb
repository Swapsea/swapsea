# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patrol_members/new', type: :view do
  before do
    @patrol_member = assign(:patrol_member, create(:member))
  end
end
