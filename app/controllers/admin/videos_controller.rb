class Admin::VideosController < AdminsController

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(admin_video_params)
    if @video.save
      flash[:success] = "You have successfully added the video '#{@video.title}'"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Your video was not saved"
      render :new
    end
  end

  private

  def admin_video_params
      params.require(:video).permit(:title, :description, :small_cover, :large_cover, :video_url, :category_id)
  end
end