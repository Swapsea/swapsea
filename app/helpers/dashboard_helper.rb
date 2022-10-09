# frozen_string_literal: true

module DashboardHelper
  def selected_user_organisation_code
    if selected_user.club?
      club_name = selected_user.club.name
      club_name.downcase.gsub(/\s/, '').delete('.')
    else
      ''
    end
  end
end
