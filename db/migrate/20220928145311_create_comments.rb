class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :testo
      t.boolean :segnalato, default: 0
      t.integer :num_segnalazioni, default: 0
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end

  end
end
