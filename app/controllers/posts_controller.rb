class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :should_user_see_page

  def index
    #binding.pry
    @posts = Post.search(params[:search_string])
    @posts = Post.filter_posts_by_genre(@posts, params[:genre][:id]) if params[:genre] && params[:genre][:id] != ""
  end

  def new
    @genres = Genre.all
    @post = Post.new
  end

  def create
    genre = Genre.find_by_name(params[:post][:genre])
    @post = Post.new(post_params)
    @post.genre = genre
    @post.user = current_user
    @post.save
    return redirect_to post_path(@post) if @post.valid?
    @genres = Genre.all
    render "new"
  end

  def show
    @sentance = Sentance.new
    @comment = Comment.new
  end

  def edit
    return redirect_to login_user_path unless current_user == @post.user
  end

  def update
    return redirect_to login_user_path unless current_user == @post.user
    @post.genre = Genre.find_by_name(params[:post][:genre])
    @post.update(post_params)
    return render 'edit' unless @post.valid?
    @post.turn_content_into_sentances(params[:post][:generate_content])
    redirect_to post_path(@post)
  end

  def search
    binding.pry
  end

  def destroy
    return redirect_to login_user_path unless current_user == @post.user
    @post.destroy
    redirect_to posts_path
  end

  private
  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :image, :other, :params)
  end

  def should_user_see_page
    return redirect_to login_user_path unless logged_in?
  end
end
