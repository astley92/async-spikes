require("rails_helper")
require("sidekiq/testing")
Sidekiq::Testing.fake!

RSpec.describe "Using the API to create a bicycle", type: :request do
  let(:run_all_jobs) { Sidekiq::Worker.drain_all }

  it "User makes request to create bicycle, polls jobs and get resource once job is complete" do
    post "/bicycles", params: {
      wheel_size: 15,
      colour: "blue",
      gear_amount: 10
    }
    job_id = JSON.parse(response.body)["job_id"]

    get "/jobs/#{job_id}"
    expect(response).to have_http_status(204)

    run_all_jobs

    get "/jobs/#{job_id}"
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to include(
      "colour" => "blue",
      "wheel_size" => 15,
      "gear_amount" => 10,
      "id" => be_a_uuid,
    )
  end
end
