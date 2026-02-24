class UserApplicationsController < ApplicationController
  def index
    @user_applications = current_user.user_applications
  end

  def new
    @user_application = UserApplication.new
  end

  def create
    @user_application = UserApplication.new(user_application_params)
    @user_application.user = current_user
    if @user_application.save
      populate_chats(@user_application)
      redirect_to new_user_application_chat_path(@user_application)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def populate_chats(user_application)
    case user_application.application_journey.application_road
    when "married"
      titles = [
        "Application Form",
        "Statement of Reasons",
        "Letter of Guarantee",
        "Employment Certificate",
        "Taxation Certificate",
        "Tax payment Certificate",
        "Monthly Pension Record"
      ]
    when "long_term"
      titles = []
    when "work"
      titles = []
    when "highly"
      titles = []
    when "special"
      titles = []
    end
    titles.each do |title|
      chat = Chat.new(title: title)
      chat.user_application = user_application
      chat.save
    end
  end

  def user_application_params
    params.require(:user_application).permit(:application_journey_id, :title)
  end
end
