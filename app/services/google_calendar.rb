require 'google/api_client/client_secrets'
require 'google/apis/calendar_v3'

class GoogleCalendar
  # Attributes Accessors (attr_writer + attr_reader)
  attr_accessor :auth_client, :auth_uri, :code

  def initialize

    # ENV: Development
    # Google's API Credentials are in ~/config/client_secret.json
    client_secrets = Google::APIClient::ClientSecrets.load( File.join( Rails.root, 'config', 'client_secret.json' ) )
    @auth_client = client_secrets.to_authorization

    # Specify privileges and callback URL
    @auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/calendar',
      :redirect_uri => 'http://localhost:3000/oauth2callback'
    )

    # Build up the Redirecting URL
    @auth_uri = @auth_client.authorization_uri.to_s

  end

end
