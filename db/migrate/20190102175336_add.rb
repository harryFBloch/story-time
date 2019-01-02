class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :numeric
  end
end
