require 'rails_helper'

RSpec.describe "event_logs/new", type: :view do
  before(:each) do
    assign(:event_log, EventLog.new(
      :type => "",
      :desc => "MyString"
    ))
  end

  it "renders new event_log form" do
    render

    assert_select "form[action=?][method=?]", event_logs_path, "post" do

      assert_select "input#event_log_type[name=?]", "event_log[type]"

      assert_select "input#event_log_desc[name=?]", "event_log[desc]"
    end
  end
end
