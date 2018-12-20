class SentancesController < ApplicationController

  def create
    @sentance = Sentance.create(sentance_params)
    @sentance.user = current_user
    @sentance.save
    @post = @sentance.post
    return render :template => "posts/show"
    redirect_to post_path(@post)
  end

  private
  def sentance_params
    params.require(:sentance).permit([:content, :post_id])
  end
end
