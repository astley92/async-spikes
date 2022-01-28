class JobsController < ApplicationController
  def show
    job = Job.find(params[:id])
    if job.finished?
      render json: job.resource, status: 200
    else
      render :no_content, status: 204
    end
  end
end
