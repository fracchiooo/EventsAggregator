class AddForeignKeyToUsersAndSegnalaCs < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "segnala_cs", "users", on_delete: :cascade
  end
end
