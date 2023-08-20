# frozen_string_literal: true

class Swap < ApplicationRecord
  belongs_to :roster, touch: true
  belongs_to :user
end
