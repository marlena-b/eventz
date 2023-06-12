# frozen_string_literal: true

class AddUniqueIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :name, unique: true
    add_index :events, :name, unique: true
    add_index :users, :email, unique: true
  end
end
