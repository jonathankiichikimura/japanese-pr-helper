class ChatsController < ApplicationController
  def show
    @chats = Chat.all
  end

  def new
  end

  def create
  end
end
