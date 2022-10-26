class AddForeignKeysToUsersAndLikeEvents < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "like_events", "users", on_delete: :cascade

  end
end
