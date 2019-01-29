class SentancesController < ApplicationController

  def create
    if sentance_params[:content].split(/(?<=[?.!])/).select(&:presence).count == 1
      @sentance = Sentance.new(sentance_params)
      @sentance.content = sentance_params[:content].split(/(?<=[?.!])/).select(&:presence)[0]
      @sentance.user = current_user
      @sentance.save
      @post = @sentance.post
      @comment = Comment.new
    else
      flash[:error] = "You can only add one sentance at a time!"
    end
    respond_to do |format|
      format.json {render json: @sentance, status: 200}
      format.html {render :template => "posts/show"}
    end
  end

  private
  def sentance_params
    params.require(:sentance).permit([:content, :post_id])
  end
end
