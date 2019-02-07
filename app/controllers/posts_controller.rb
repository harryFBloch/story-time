class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :should_user_see_page
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :get_nested_post, only: [:next, :get_sentance_content_for_post]

  def index
    @posts = Post.search(params[:search_string])
    @posts = Post.filter_posts_by_genre(@posts, params[:genre_id]) if params[:genre_id] && params[:genre_id] != ""
    @total_posts = Post.all.length
    respond_to do |format|
      format.json {render json: @posts , status: 200}
      format.html {}
    end
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
    respond_to do |format|
      format.json {render json: @post, status: 200}
      format.html {}
    end
  end

  def edit
  end

  def update
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
    @post.destroy
    redirect_to posts_path
  end

  def next
    render json: @post.next_or_prev_post(params[:next_bool])
  end

  def get_sentance_content_for_post
    render json: @post.get_json_content_for_post(current_user)
  end

  private
  def get_post
    @post = Post.find(params[:id])
  end

  def get_nested_post
    @post = Post.find(params[:post_id])
  end

  def check_user
    return redirect_to login_user_path unless current_user == @post.user
  end

  def post_params
    params.require(:post).permit(:title, :image, :other, :params)
  end

  def should_user_see_page
    return redirect_to login_user_path unless logged_in?
  end
end
