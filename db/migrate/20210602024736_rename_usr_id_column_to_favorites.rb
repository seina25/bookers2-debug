class RenameUsrIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :usr_id, :user_id
  end
end
