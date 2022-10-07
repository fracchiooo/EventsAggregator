class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_id
      t.string :organizer_id
      t.string :coordinates

      t.timestamps
    end
  end
end
