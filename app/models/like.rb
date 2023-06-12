# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
