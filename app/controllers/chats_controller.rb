class ChatsController < ApplicationController
  def show
    @user_application = UserApplication.find(params[:user_application_id])
    # @chat = @user_application.chats.first
    @chats = @user_application.chats
    @chat = @user_application.chats.find_by(id: params[:id])
    if @chat.nil? # rubocop:disable Style/IfUnlessModifier
      redirect_to user_application_chat_path(@user_application, @chats.first)
    end
    @newchat = Chat.new
  end

  def create
    @user_application = UserApplication.find(params[:user_application_id])
    @newchat = Chat.new(chat_params)
    @newchat.user_application = @user_application
    if @newchat.save
      redirect_to user_application_chat_path(@user_application, @newchat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user_application = UserApplication.find(params[:user_application_id])
    chat = Chat.find(params[:id])
    chat.destroy
    redirect_to user_application_chat_path(@user_application)
  end

  private

  def chat_params
    params.require(:chat).permit(:title)
  end
end
