require 'elasticsearch/model'
require 'faraday_middleware/aws_sigv4'

Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['BONSAI_URL'],
  log: true,
  transport_options: {
    request: { timeout: 5 },
    headers: { 'X-elastic-product-origin' => 'elasticsearch' }
  }
) do |f|
  f.adapter  Faraday.default_adapter
  f.response :logger                  # for debugging
  f.headers['X-elastic-product-origin'] = 'elasticsearch'
end
