class AddDescriptionAndReleasedOnToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :description, :text
    add_column :events, :released_on, :date
  end
end
