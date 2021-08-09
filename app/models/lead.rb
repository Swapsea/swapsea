# frozen_string_literal: true

class Lead < ApplicationRecord
  validates :name, :organisation, :email, presence: { message: 'Cannot be blank.' }
  validates :email, uniqueness: { message: 'This email has already been submitted.' }
end
