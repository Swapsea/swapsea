# frozen_string_literal: true

module DashboardHelper
  def selected_user_organisation_code
    if (organisation = selected_user.try :organisation)
      organisation.downcase.gsub /\s/, ''
    else
      ''
    end
  end
end
