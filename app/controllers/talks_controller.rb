class TalksController < ApplicationController
  before_action :set_room

  def index
    @talks = Talk.all
    @talks = @room.talks.includes(:user)
    @rooms = Room.find_by(params[:id])
    gon.room = @rooms.period
  end

  def new
    @talk = Talk.new
    @talks = @room.talks.includes(:user)
  end

  def create
    @talk = @room.talks.new(talks_params)
    if @talk.save
      respond_to do |format|
      format.json
      end
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      redirect_to room_talks_path(room.id)
  end

  def show
    @talks = Talk.find_by(params[:id])
  end


  def talks_params
    params.require(:talk).permit(:text, :image, :status_id).merge(user_id: current_user.id)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
