class CreatePartecipants < ActiveRecord::Migration[7.0]
  def change
    create_table :partecipants do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key "partecipants", "users", on_delete: :cascade
  end
end
