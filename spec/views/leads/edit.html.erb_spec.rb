# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leads/edit', type: :view do
  before do
    @lead = assign(:lead, create(:lead))
  end

  it 'renders the edit lead form' do
    render

    assert_select 'form[action=?][method=?]', lead_path(@lead), 'post' do
      assert_select 'input#lead_name[name=?]', 'lead[name]'

      assert_select 'input#lead_email[name=?]', 'lead[email]'

      assert_select 'input#lead_organisation[name=?]', 'lead[organisation]'
    end
  end
end
