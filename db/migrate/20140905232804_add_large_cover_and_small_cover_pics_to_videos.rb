class AddLargeCoverAndSmallCoverPicsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :large_cover_pic, :string
    add_column :videos, :small_cover_pic, :string
    remove_column :videos, :large_cover_url
    remove_column :videos, :small_cover_url
  end
end
