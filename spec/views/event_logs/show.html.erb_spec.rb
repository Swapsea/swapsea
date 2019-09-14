require 'rails_helper'

RSpec.describe "event_logs/show", type: :view do
  before(:each) do
    @event_log = assign(:event_log, EventLog.create!(
      :type => "Type",
      :desc => "Desc"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Desc/)
  end
end
