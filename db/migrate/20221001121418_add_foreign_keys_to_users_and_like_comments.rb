class AddForeignKeysToUsersAndLikeComments < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "like_comments", "users", on_delete: :cascade
  end
end
