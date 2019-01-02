class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = @comment.post
    @sentance = Sentance.new
    return render :template => 'posts/show' unless @comment.valid?
    @comment.save
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
