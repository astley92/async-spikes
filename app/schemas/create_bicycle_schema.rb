class CreateBicycleSchema < Dry::Validation::Contract
  params do
    required(:wheel_size).filled(:integer)
    required(:colour).filled(:string)
    required(:gear_amount).filled(:integer)
  end

  rule(:wheel_size, :gear_amount) do
    if values[:wheel_size] < values[:gear_amount]
      key.failure("must be greater than or equal to gear_amount")
    end
  end

  rule(:wheel_size) do
    key.failure("must be less than or equal to 20") if values[:wheel_size] > 20
  end

  rule(:colour) do
    if value.length > 10
      key.failure("string length must be less than or equal to 10 characters")
    end

    # not quite right I know but meh
    if value.include?(" ")
      key.failure("must only be one word")
    end
  end
end
