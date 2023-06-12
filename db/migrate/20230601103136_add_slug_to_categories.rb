# frozen_string_literal: true

class AddSlugToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :slug, :string
  end
end
