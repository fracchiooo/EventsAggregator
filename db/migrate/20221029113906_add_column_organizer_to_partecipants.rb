class AddColumnOrganizerToPartecipants < ActiveRecord::Migration[7.0]
  def change
    add_column :partecipants, :organizer_id, :string
  end
end
