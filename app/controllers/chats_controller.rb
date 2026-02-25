class ChatsController < ApplicationController
  before_action :set_user_application, only: %i[show create destroy]
  def show
    # @chat = @user_application.chats.first
    @chats = @user_application.chats.order(done: :asc, created_at: :desc)
    @chat = @user_application.chats.find_by(id: params[:id])
    @newchat = Chat.new
  end

  def create
    @newchat = Chat.new(chat_params)
    @newchat.user_application = @user_application
    if @newchat.save
      redirect_to user_application_chat_path(@user_application, @newchat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    redirect_to user_application_chat_path(@user_application,
                                           @user_application.chats.where(done: false).order(id: :desc).first)
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(done_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path) }
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:title)
  end

  def done_params
    params.require(:chat).permit(:done)
  end

  def set_user_application
    @user_application = UserApplication.find(params[:user_application_id])
  end
end
