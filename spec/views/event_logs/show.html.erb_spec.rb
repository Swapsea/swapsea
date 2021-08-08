require 'rails_helper'

RSpec.describe 'event_logs/show', type: :view do
  before(:each) do
    @event_log = assign(:event_log, FactoryBot.create(:event_log))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Desc/)
  end
end
