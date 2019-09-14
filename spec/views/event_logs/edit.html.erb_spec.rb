require 'rails_helper'

RSpec.describe "event_logs/edit", type: :view do
  before(:each) do
    @event_log = assign(:event_log, EventLog.create!(
      :type => "",
      :desc => "MyString"
    ))
  end

  it "renders the edit event_log form" do
    render

    assert_select "form[action=?][method=?]", event_log_path(@event_log), "post" do

      assert_select "input#event_log_type[name=?]", "event_log[type]"

      assert_select "input#event_log_desc[name=?]", "event_log[desc]"
    end
  end
end
