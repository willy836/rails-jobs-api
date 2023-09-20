class Api::V1::JobsController < ApplicationController
  before_action :authenticate_request
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    @jobs = @current_user.jobs
    render json: { jobs: @jobs }, status: :ok
  end

  def show
    if @job.author == @current_user
      render json: { job: @job }, status: :ok
    else
      render json: { error: 'Job not found' }, status: :not_found
    end
  end

  def create
    @job = Job.new(job_params)
    @job.author = @current_user

    if @job.save
      render json: { job: @job }, status: :created
    else
      render json: { errors: @job.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @job.author == @current_user
      if @job.update(job_params)
        render json: { job: @job }, status: :ok
      else
        render json: { errors: @job.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized to update this job' }, status: :unauthorized
    end
  end

  def destroy
    if @job.author == @current_user
      if @job.destroy
        head :no_content # Shorthand way to set the response status to 204 No Content without including a response body
      else
        render json: { errors: @job.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized to delete this job' }, status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:company, :position, :status, :author_id)
  end
end
