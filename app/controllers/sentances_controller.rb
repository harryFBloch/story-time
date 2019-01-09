class SentancesController < ApplicationController

  def create
    #binding.pry

    if sentance_params[:content].split(/(?<=[?.!])/).select(&:presence).count == 1
      @sentance = Sentance.new(sentance_params)
      @sentance.content = sentance_params[:content].split(/(?<=[?.!])/).select(&:presence)[0]
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
