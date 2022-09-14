# frozen_string_literal: true

module ApplicationHelper
  def title_tag
    ['Swapsea', content_for(:title)].compact.join(' | ')
  end
end
