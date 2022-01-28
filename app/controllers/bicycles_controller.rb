class BicyclesController < ApplicationController
  def create
    result = CreateBicycleSchema.new.call(bicycle_params)

    if result.success?
      job = Job.create(state: "pending")
      render json: {job_id: job.id}, status: 202
      CreateBicycleJob.perform_async(job.id, bicycle_params)
    else
      error_hash = result.errors.to_h
      render json: { errors: error_hash}, status: 400
    end

  end

  private

  def bicycle_params
    params.permit(:wheel_size, :gear_amount, :colour).to_h
  end
end
