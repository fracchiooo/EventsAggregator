class AddForeignKeyToCommentsAndSegnalaCs < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "segnala_cs", "comments", on_delete: :cascade

  end
end
