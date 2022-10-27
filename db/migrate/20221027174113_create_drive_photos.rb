class CreateDrivePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :drive_photos do |t|
      t.references :user, null: false
      t.references :event, null: false
      t.string :drive_url, null: false, index: { unique: true }

      t.timestamps
    end
    add_index :drive_photos, [:user_id, :event_id]

    add_foreign_key :drive_photos, :users, on_delete: :cascade
    add_foreign_key :drive_photos, :events, on_delete: :cascade
  end
end
