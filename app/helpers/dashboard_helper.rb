# frozen_string_literal: true

module DashboardHelper
  def selected_user_organisation_code
    if selected_user.club?
      organisation = selected_user.club.name
      organisation.downcase.gsub(/\s/, '').delete('.')
    else
      ''
    end
  end
end
