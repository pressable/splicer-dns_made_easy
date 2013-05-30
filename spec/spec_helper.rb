require 'rspec'
require 'splicer'
require 'splicer/dns_made_easy'

RSpec.configure do |config|
  config.mock_with :rspec
end

Splicer.configure do |config|
end
