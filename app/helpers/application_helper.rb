# frozen_string_literal: true
module ApplicationHelper

  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? 'Swapsea | ' + content_for(:title) : 'Swapsea'
    end
  end

end
