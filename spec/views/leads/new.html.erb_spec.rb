require 'faker'
require 'rails_helper'

RSpec.describe 'leads/new', type: :view do
  before(:each) do
    assign(:lead, Lead.new(
      :name => 'Name',
      :email => 'Faker::Internet.email',
      :organisation => 'Organisation'
    ))
  end

  it 'renders the edit lead form' do
    render

    assert_select 'form[action=?][method=?]', leads_path, 'post' do

      assert_select 'input#lead_name[name=?]', 'lead[name]'

      assert_select 'input#lead_email[name=?]', 'lead[email]'

      assert_select 'input#lead_organisation[name=?]', 'lead[organisation]'

    end
  end
end
