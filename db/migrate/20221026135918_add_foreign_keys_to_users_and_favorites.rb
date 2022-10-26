class AddForeignKeysToUsersAndFavorites < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "favorites", "users", on_delete: :cascade

  end
end
