class CommentsController < ApplicationController

  def index

    @comments = Comment.where(post_id: params[:post_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end

  end
  
  def create
    comment = Comment.new(
      text: params[:text],
      author_id: current_user.id,
      post_id: params[:post_id]
    )

    if comment.save
      redirect_to user_post_path(id: params[:post_id])
      flash[:notice] = 'You have successfully created a comment'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Your comment was not created'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to user_posts_path
    flash[:notice] = 'You have succesfully deleted a comment'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
