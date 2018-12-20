class AddUserToSentances < ActiveRecord::Migration[5.2]
  def change
    add_column :sentances, :user_id, :integer
  end
end
