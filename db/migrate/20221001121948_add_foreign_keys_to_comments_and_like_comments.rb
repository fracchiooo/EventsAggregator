class AddForeignKeysToCommentsAndLikeComments < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "like_comments", "comments", on_delete: :cascade

  end
end
