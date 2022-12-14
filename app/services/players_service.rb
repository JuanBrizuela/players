# frozen_string_literal: true

class PlayersService
  class << self
    def import
      data = fetch_data

      # The transaction simplifies knowing if the API
      # changes or there is an difference between the
      # schema and the API response
      Player.transaction do
        data['body']['players'].each do |player_data|
          Player.create!(player_params(player_data))
        end
      end
    end

    private

    def fetch_data
      response = RestClient.get('http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON')
      JSON.parse(response.body)
    end

    def player_params(params)
      params.tap do |v|
        v['external_id'] = v.delete('id')
        v['first_name'] = v.delete('firstname')
        v['last_name'] = v.delete('lastname')
        v['full_name'] = v.delete('fullname')
        v['photo_url'] = v.delete('photo')
      end
    end
  end
end
