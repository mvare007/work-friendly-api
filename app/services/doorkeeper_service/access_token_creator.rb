module DoorkeeperService
  class AccessTokenCreator
    include Callable

    def initialize(resource_owner, client_app, scopes = '')
      @resource_owner = resource_owner
      @client_app = client_app
      @scopes = scopes
    end

    def call
      create_access_token
    end

    private

    def create_access_token
      Doorkeeper::AccessToken.create(
        resource_owner_id: @resource_owner.id,
        application_id: @client_app.id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: @scopes
      )
    end

    def generate_refresh_token
      loop do
        refresh_token = SecureRandom.hex(32)
        break refresh_token unless Doorkeeper::AccessToken.exists?(refresh_token:)
      end
    end
  end
end
