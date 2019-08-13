class CommentsController < ApplicationController

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    # debugger
    if params[:comment][:comment_id] 
      @comment.comment_id = params[:comment][:comment_id] 
    else
      @comment.comment_id = nil
    end

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else 
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @children = @comment.child_comments
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :comment_id)
  end


end
