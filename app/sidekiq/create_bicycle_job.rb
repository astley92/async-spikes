class CreateBicycleJob
  include Sidekiq::Job

  def perform(job_id, bicycle_params)
    bicycle = Bicycle.create(bicycle_params)
    job = Job.find(job_id)
    job.update!(
      resource: bicycle,
      state: "finished",
    )
  end
end
