class AddDetailToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :detail, :text
    add_reference :events, :user, foreign_key: true
  end
end
