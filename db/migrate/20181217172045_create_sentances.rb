class CreateSentances < ActiveRecord::Migration[5.2]
  def change
    create_table :sentances do |t|
      t.string :content
      t.integer :post_id

      t.timestamps
    end
  end
end
