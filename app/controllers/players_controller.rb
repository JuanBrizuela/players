class PlayersController < ApplicationController
  before_action :set_player, only: :show

  def show
    respond_to do |format|
      format.html { render json: @player.to_json }
      format.json { render json: @player.to_json }
    end
  end

  def index
    @players = Player.all

    respond_to do |format|
      format.html { render json: @players.to_json }
      format.json { render json: @players.to_json }
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end
end
