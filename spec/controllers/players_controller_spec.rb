require 'rails_helper'

RSpec.describe PlayersController do
  let(:json_response) { JSON.parse(response.body) }

  describe '#show' do
    it 'works' do
      get :show, params: { id: players(:sample) }

      expect(response).to have_http_status :ok
      expect(json_response.keys).to match_array %w[
        external_id
        first_name
        last_name
        position
        age
        average_position_age_diff
        name_brief
      ]
    end
  end
end
