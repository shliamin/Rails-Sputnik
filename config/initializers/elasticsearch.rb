Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['BONSAI_URL'],
  log: true,
  transport_options: {
    request: { timeout: 5 }
  }
)
