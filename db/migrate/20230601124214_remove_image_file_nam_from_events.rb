# frozen_string_literal: true

class RemoveImageFileNamFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :image_file_name, :string
  end
end
