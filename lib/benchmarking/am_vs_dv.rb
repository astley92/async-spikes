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
#          ActiveModel     4.363k i/100ms
#      dry-validations   203.000  i/100ms
# Calculating -------------------------------------
#          ActiveModel     43.838k (± 2.0%) i/s -    222.513k in   5.077880s
#      dry-validations      2.059k (± 1.2%) i/s -     10.353k in   5.029151s

# Comparison:
#          ActiveModel:    43838.3 i/s
#      dry-validations:     2058.9 i/s - 21.29x  (± 0.00) slower
