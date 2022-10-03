class CreateSegnalaCs < ActiveRecord::Migration[7.0]
  def change
    create_table :segnala_cs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end

    add_index :segnala_cs,[:user_id, :comment_id], unique:true
  end
end
