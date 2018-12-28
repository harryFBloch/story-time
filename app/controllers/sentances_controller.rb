class SentancesController < ApplicationController

  def create
    if sentance_params[:content].split(/(?<=[?.!])/).count == 1
      @sentance = Sentance.create(sentance_params)
      @sentance.user = current_user
      @sentance.save
      @post = @sentance.post
      @comment = Comment.new
      return render :template => "posts/show"
    else
      flash[:error] = "You can only add one sentance at a time!"
    end
    redirect_to post_path(sentance_params[:post_id])
  end

  private
  def sentance_params
    params.require(:sentance).permit([:content, :post_id])
  end
end
