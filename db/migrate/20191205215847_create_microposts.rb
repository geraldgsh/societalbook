class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content

      t.timestamps
    end
    add_index :microposts, [:user, :created_at]
  end
end
