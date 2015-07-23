VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = "spec/cassettes"
  config.allow_http_connections_when_no_cassette = true

  config.around_http_request do |request|
    VCR.use_cassette('braintree_create_user', :record => :new_episodes, &request)
  end
end
