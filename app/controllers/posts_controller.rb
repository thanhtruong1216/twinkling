class PostsController < ApplicationController
  before_action :set_post, only: %w[edit update destroy like unlike]
  before_action :owned_post, only: %w[edit update destroy]

  def index
    EventTrack.create(name: 'View posts', user_id: current_user.id)
    
    @posts = Post.with_attached_photo
      .includes(user: { avatar_attachment: :blob })
      .order(created_at: :desc)
      .limit(10)
      .page(params[:page])
  end

  def show
    EventTrack.create(name: 'View a post', user_id: current_user.id)
    @post = Post.includes(:comments, :likes).friendly.find(params[:id])
  end

  def new
    @post = current_user.posts.build
    EventTrack.create(name: 'Prepare a post', user_id: current_user.id)
  end

  def create
    EventTrack.create(name: 'Create a post', user_id: current_user.id)

    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Your post has been created!'
      redirect_to @post
    else
      flash[:danger] = "Your new post couldn't be created! Please check the form."
      render 'new'
    end
  end

  def edit
    EventTrack.create(name: 'Edit a post', user_id: current_user.id)
    @post = Post.includes(:comments).friendly.find(params[:id])
  end

  def update
    if @post.update(post_params)
      # redirect_to @post
      EventTrack.create(name: 'Update a post', user_id: current_user.id)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    EventTrack.create(name: 'Destroy a post', user_id: current_user.id)

    @post.destroy

    redirect_to posts_path
  end

  def like
    EventTrack.create(name: 'Like a post', user_id: current_user.id)

    @post.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def unlike
    EventTrack.create(name: 'Unlike a post', user_id: current_user.id)

    likes = @post.likes.where(user_id: current_user.id)
    if likes.count > 0
      likes.destroy_all
    else
      flash[:notice] = "Cannot unlike"
    end
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  private

  def post_params
    params.require(:post).permit(:photo, :content, :author, :origin)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def owned_post
    unless current_user.id == @post.user.id
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
