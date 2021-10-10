class RenameJenreIdColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :jenre_id, :genre_id
  end
end
