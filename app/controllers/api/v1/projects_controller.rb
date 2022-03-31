class Api::V1::ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy, :add_member]
    before_action :set_member, only: [:add_member]

    def index
        @projects = Project.all
        render json: @projects
    end

    def show
        render json: @project
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            render json: @project
        else
            render json: @project.errors.full_messages, status: 422
        end
    rescue ActiveRecord::NotNullViolation => e
        render json: { error: e.message }, status: 422
    end

    def update
        if @project.update(project_params)
            render json: @project
        else
            render json: @project.errors.full_messages, status: 422
        end
    end

    def destroy
        if @project.destroy
          render json: { success: "Project is deleted" }
        else
          render json: { error: "Project could not be deleted" }, status: 422
        end
      end

    def project_members
        @project = Project.find(params[:project_id])
        render json: @project.members
    end

    def add_member
        if @member && @project
            @project.members << @member
            render json: { success: "The member is added to the project" }
        else
            render json: { error: "Member could not be added the project" }, status: 422
        end
    end

    private

    def set_project
        begin
            if params[:project_id]
                @project = Project.find(params[:project_id])
            else
                @project = Project.find(params[:id])
            end
        rescue
            render json: { error: "Project not found" }, status: 422
        end
    end

    def set_member
        begin
            @member = Member.find(params[:member_id])
        rescue
            render json: { error: "Member not found" }, status: 422
        end
    end
  
    # Only allow a list of trusted parameters through.
    def project_params
      params.permit(:name)
    end
end
