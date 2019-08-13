class PostsController < ApplicationController
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id 
    # debugger
    @post.sub_ids = post_params[:sub_ids]

    if @post.save
      redirect_to post_url(@post)
    else  
      debugger
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url(@post)
    end
  end

  def index
    @sub = Sub.find(params[:sub_id])

    @posts = @sub.posts
    render :index
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = []
    render :show
  end

  def edit 
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    @post.sub_ids = post_params[:sub_ids]

    if @post.update(post_params)
      redirect_to post_url(@post)
    else  
      flash[:errors] = @post.errors.full_messages
      debugger
      redirect_to edit_post_url(@post)
    end
  end   

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end


end
