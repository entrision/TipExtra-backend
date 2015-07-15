module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def json
    @json || JSON.parse(last_response.body)
  end

  def header_login(user = create(:user))
    header 'Authorization', "Token token=#{user.authentication_token}"
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :api
end
