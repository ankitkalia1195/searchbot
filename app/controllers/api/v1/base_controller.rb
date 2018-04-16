module Api
  module V1
    class BaseController < ActionController::API

      before_action :doorkeeper_authorize!
      respond_to :json

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

  # curl -X POST -d 'grant_type=password&email=ankitkalia.dev@gmail.com&password=123456' localhost:3000/api/v1/oauth/token
  # curl -X GET -d 'access_token=173e4dcd589de113287d1f6910deee229e3faf28c90589a76584ae899062f58' localhost:3000/api/v1/links

    end
  end
end
