class AddForeignKeysToCommentsAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "comments", "users", on_delete: :cascade

  end
end
