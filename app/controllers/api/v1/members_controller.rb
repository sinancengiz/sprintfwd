class Api::V1::MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

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
          render json: { success: "Member is deleted" }
        else
          render json: { error: "Member could not be deleted" }, status: 422
        end
      end

    private

    def set_member
        begin
            @member = Member.find(params[:id])
        rescue
            render json: { error: "Member not found" }, status: 422
        end
    end
  
    # Only allow a list of trusted parameters through.
    def member_params
      params.permit(:fisrt_name, :last_name, :city, :state, :country, :team_id)
    end
end
