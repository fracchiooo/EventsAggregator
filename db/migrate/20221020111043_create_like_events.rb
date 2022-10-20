class CreateLikeEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :like_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :promoter
      t.boolean :like

      t.timestamps
    end
    add_index :like_events, [:user_id, :event_id], unique: true
  end
end
