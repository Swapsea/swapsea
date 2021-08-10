# frozen_string_literal: true

class NoticeAcknowledgement < ApplicationRecord
  belongs_to :notice
  belongs_to :user
end
