require 'rails_helper'

RSpec.describe 'event_logs/index', type: :view do
  before(:each) do
    assign(:event_logs, [
      EventLog.create!(
        :subject => 'Subject',
        :desc => 'Desc'
     ),
      EventLog.create!(
        :subject => 'Subject',
        :desc => 'Desc'
     )
    ])
  end

  it 'renders a list of event_logs' do
    render
    assert_select 'tr>td', :text => 'Subject'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Desc'.to_s, :count => 2
  end
end
