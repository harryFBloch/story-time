class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = @comment.post
    @sentance = Sentance.new
    return render :template => 'posts/show' unless @comment.valid?
    @comment.save
    respond_to do |format|
      format.json {render json: @comment, status: 200}
      format.html {redirect_to post_path(@post)}
    end
  end

  def comments_for_post
    @comments = Post.find(params[:post_id]).comments
    respond_to do |format|
      format.json {render json: @comments, status: 200}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
