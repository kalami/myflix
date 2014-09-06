class RenamePicColumns < ActiveRecord::Migration
  def change
    rename_column :videos, :large_cover_pic, :large_cover
    rename_column :videos, :small_cover_pic, :small_cover
  end
end
