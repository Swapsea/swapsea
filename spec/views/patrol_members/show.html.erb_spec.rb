# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patrol_members/show', type: :view do
  before do
    @patrol_member = assign(:patrol_member, create(:patrol_member))
  end

  it 'renders attributes in <p>' do
    render
  end
end
