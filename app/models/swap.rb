# frozen_string_literal: true

class Swap < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller && controller.selected_user }

  belongs_to :roster, touch: true
  belongs_to :user
end
