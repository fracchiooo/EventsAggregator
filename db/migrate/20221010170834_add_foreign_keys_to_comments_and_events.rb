class AddForeignKeysToCommentsAndEvents < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "comments", "events", on_delete: :cascade

  end
end
