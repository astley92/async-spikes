require("rails_helper")

RSpec.describe "creating a bicycle resource", type: :request do
  subject(:make_request) { post "/bicycles", params: params }
  let(:params) do
    {
      wheel_size: 15,
      colour: "blue",
      gear_amount: 10
    }
  end

  it "responds with a job id" do
    make_request

    expect(response).to have_http_status(:accepted)
    expect(JSON.parse(response.body)).to include(
      "job_id" => be_a_uuid
    )
  end

  context "when the request is missing required parameters" do
    let(:params) do
      {
        wheel_size: 15,
        colour: "blue"
      }
    end

    it "the response is a 400 and includes what fields are missing" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "gear_amount" => ["is missing"]
        }
      )
    end
  end

  context "when the wheel size is not an integer" do
    let(:params) do
      {
        wheel_size: "shouldnt work",
        colour: "blue",
        gear_amount: 10
      }
    end

    it "the response is a 400 and includes details about the error" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "wheel_size" => ["must be an integer"]
        }
      )
    end
  end

  context "when the wheel size is too big" do
    let(:params) do
      {
        wheel_size: 100,
        colour: "blue",
        gear_amount: 10
      }
    end

    it "the response is a 400 and includes details about the error" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "wheel_size" => ["must be less than or equal to 20"]
        }
      )
    end
  end

  context "when the colour string is too long" do
    let(:params) do
      {
        wheel_size: 12,
        colour: "imwayyyyyyyyyyyyyyyyyyyyyyytolong",
        gear_amount: 10
      }
    end

    it "the response is a 400 and includes details about the error" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "colour" => ["string length must be less than or equal to 10 characters"]
        }
      )
    end
  end

  context "when the colour string contains more than one word" do
    let(:params) do
      {
        wheel_size: 12,
        colour: "not right",
        gear_amount: 10
      }
    end

    it "the response is a 400 and includes details about the error" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "colour" => ["must only be one word"]
        }
      )
    end
  end

  # don't know why this would be a validation, but it is :)
  context "when the wheel size is less than the gear amount" do
    let(:params) do
      {
        wheel_size: 9,
        colour: "blue",
        gear_amount: 10
      }
    end

    it "the response is a 400 and includes details about the error" do
      make_request
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to include(
        "errors" => {
          "wheel_size" => ["must be greater than or equal to gear_amount"]
        }
      )
    end
  end
end
