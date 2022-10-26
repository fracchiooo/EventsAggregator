class AddColumnOriginToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :origin, :string
  end
end
