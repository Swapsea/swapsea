# frozen_string_literal: true

class Swap < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.selected_user }

  belongs_to :roster, touch: true
  belongs_to :user
end
