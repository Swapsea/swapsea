# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'awards/show' do
  before do
    @award = assign(:award, Award.create!(
                              award_number: 'AwardNumber2',
                              award_name: 'AwardName',
                              user_id: '1'
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/AwardNumber2/)
    expect(rendered).to match(/AwardName/)
    expect(rendered).to match(/1/)
  end
end
