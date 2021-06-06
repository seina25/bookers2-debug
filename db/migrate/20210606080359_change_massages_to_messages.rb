class ChangeMassagesToMessages < ActiveRecord::Migration[5.2]
  def change
    rename_table :massages, :messages
  end
end
