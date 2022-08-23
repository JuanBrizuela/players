class PlayersController < ApplicationController
  before_action :set_player, only: :show

  def show
    respond_to do |format|
      format.html { render json: @player.to_json }
      format.json { render json: @player.to_json }
    end
  end

  def index
    @players = PlayersFilterService.new(Player.all, filter_params[:filters]).filter

    respond_to do |format|
      format.html { render json: @players.to_json }
      format.json { render json: @players.to_json }
    end
  end

  private

  def filter_params
    params.permit(filters: [:property, :operator, { values: [] }])
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
