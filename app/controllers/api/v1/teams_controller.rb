# app/controllers/api/v1/teams_controller.rb
class Api::V1::TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  def index
    @teams = Team.all
    render json: @teams
  end

  def show
    render json: @team
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render json: @team
    else
      render json: @team.errors.full_messages, status: 422
    end
  rescue ActiveRecord::NotNullViolation => e
    render json: { error: e.message }, status: 422
  end

  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors.full_messages, status: 422
    end
  end

  def destroy
    if @team.destroy
      render json: { success: 'Team is deleted' }
    else
      render json: { error: 'Team could not be deleted' }, status: 422
    end
  end

  def team_members
    @team = Team.find(params[:team_id])
    render json: @team.members
  end

  private

  def set_team
    @team = Team.find(params[:id])
  rescue StandardError
    render json: { error: 'Team not found' }, status: 422
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.permit(:name)
  end
end
