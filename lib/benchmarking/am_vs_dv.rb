require 'benchmark/ips'

params = { wheel_size: 100, colour: "blue" }

contract = CreateBicycleSchema.new

Benchmark.ips do |x|
  x.report("ActiveModel") do
    Bicycle.new(params).validate
  end

  x.report("dry-validations") do
    contract.call(params)
  end

  x.compare!
end

# Warming up --------------------------------------
#          ActiveModel     1.338k i/100ms
#      dry-validations   203.000  i/100ms
# Calculating -------------------------------------
#          ActiveModel     13.592k (± 0.9%) i/s -     68.238k in   5.020643s
#      dry-validations      2.045k (± 1.3%) i/s -     10.353k in   5.062363s

# Comparison:
#          ActiveModel:    13592.5 i/s
#      dry-validations:     2045.4 i/s - 6.65x  (± 0.00) slower
