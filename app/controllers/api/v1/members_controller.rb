# app/controllers/api/v1/members_controller.rb
class Api::V1::MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]
  before_action :set_team, only: [:update_team]

  def index
    @members = Member.all
    render json: @members
  end

  def show
    render json: @member
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      render json: @member
    else
      render json: @member.errors.full_messages, status: 422
    end
  rescue ActiveRecord::NotNullViolation => e
    render json: { error: e.message }, status: 422
  end

  def update
    if @member.update(member_params)
      render json: @member
    else
      render json: @member.errors.full_messages, status: 422
    end
  end

  def destroy
    if @member.destroy
      render json: { success: 'Member is deleted' }
    else
      render json: { error: 'Member could not be deleted' }, status: 422
    end
  end

  def update_team
    @member = Member.find(params[:member_id])
    @member.team_id = @team.id
    if @member.save
      render json: @member
    else
      render json: @member.errors.full_messages, status: 422
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  rescue StandardError
    render json: { error: 'Member not found' }, status: 422
  end

  def set_team
    @team = Team.find(params[:team_id])
  rescue StandardError
    render json: { error: 'Team not found' }, status: 422
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.permit(:first_name, :last_name, :city, :state, :country, :team_id)
  end
end
