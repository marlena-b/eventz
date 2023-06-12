# frozen_string_literal: true

class Categorization < ApplicationRecord
  belongs_to :event
  belongs_to :category
end
