require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Patreon < OmniAuth::Strategies::OAuth2
      option :name, 'patreon'

      option :client_options,
             site: 'https://www.patreon.com',
             authorize_url: 'https://www.patreon.com/oauth2/authorize',
             token_url: 'https://api.patreon.com/oauth2/token'

      uid { raw_info['data']['id'].to_s }

      info do
        {
          email: raw_info['data']['attributes']['email'],
          name: raw_info['data']['attributes']['full_name'],
          access_token: access_token.token,
          refresh_token: access_token.refresh_token
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= begin
          response = client.request(:get, 'https://api.patreon.com/oauth2/api/current_user', headers: {
                                      'Authorization' => "Bearer #{access_token.token}"
                                    }, parse: :json)
          response.parsed
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
