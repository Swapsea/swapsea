require 'rails_helper'

RSpec.describe 'clubs/show', type: :view do
  before(:each) do
    @club = assign(:club, FactoryBot.create(:club))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Short name/)
  end
end
