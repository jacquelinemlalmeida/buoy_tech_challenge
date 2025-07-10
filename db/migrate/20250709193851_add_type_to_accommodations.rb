class AddTypeToAccommodations < ActiveRecord::Migration[7.1]
  def change
    add_column :accommodations, :type, :string
    add_index :accommodations, :type
  end
end
