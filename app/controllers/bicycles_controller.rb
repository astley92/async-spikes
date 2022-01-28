class BicyclesController < ApplicationController
  def create
    result = CreateBicycleSchema.new.call(permitted_params.to_h)

    if result.success?
      job = Job.create(state: "pending")
      render json: {job_id: job.id}, status: 202
    else
      error_hash = result.errors.to_h
      render json: { errors: error_hash}, status: 400
    end
  end

  private

  def permitted_params
    params.permit(:wheel_size, :gear_amount, :colour)
  end
end
