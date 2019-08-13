class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update] 
  before_action :require_logged_in, only: [:edit, :update, :new, :create] 

    def new
      @sub = Sub.new
      :new
    end

    def create
      @sub = Sub.create(sub_params)
      @sub.moderator_id = current_user.id
      if @sub.save
        redirect_to sub_url(@sub)
      else
        flash[:errors] = @sub.errors.full_messages
        flash[:title] = @sub.title
        flash[:description] = @sub.description
        render :new
      end
    end

    def edit
      @sub = Sub.find(params[:id])
    end

    def update
      @sub = Sub.find(params[:id])
      if @sub.update(sub_params)
        redirect_to sub_url(@sub)
      else
        flash[:errors] = @sub.errors.full_messages
        redirect_to sub_url(@sub)
      end
    end

    def show
      @sub = Sub.find(params[:id])
    end

    def index
      @subs = Sub.all
    end
    private

    def ensure_moderator
      sub = Sub.find(params[:id])
      redirect_to new_session_url unless sub.moderator_id == current_user.id
    end

    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
