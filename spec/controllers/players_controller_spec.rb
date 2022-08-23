require 'rails_helper'

RSpec.describe PlayersController do
  let(:json_response) { JSON.parse(response.body) }

  before { make_request }

  describe '#show' do
    let(:player) { players(:test) }
    subject(:make_request) { get :show, params: { id: player.id } }

    it 'returns :ok' do
      expect(response).to have_http_status :ok
    end

    it 'returns the serialized player' do
      expect(json_response['age']).to eq player.age
      expect(json_response['external_id']).to eq player.external_id
      expect(json_response['first_name']).to eq player.first_name
      expect(json_response['last_name']).to eq player.last_name
      expect(json_response['position']).to eq player.position

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

  describe '#index' do
    subject(:make_request) { get :index, params: params }
    subject(:should_retrieve_records) { expect(json_response.size).to be >= 1 }
    subject(:should_include_player) { expect(json_response.pluck('id')).to include player.id }
    let(:params) { {} }

    it 'returns :ok' do
      expect(response).to have_http_status :ok
    end

    it 'returns the right amount of records' do
      expect(json_response.size).to eq Player.count
    end

    context 'when filtering by age' do
      describe 'with eq operator' do
        let(:player) { players(:young_guy) }
        let(:params) { { filters: [{ property: 'age', operator: 'eq', values: [player.age]}] } }

        it "retrieves records with a matching age" do
          should_retrieve_records
          should_include_player
        end
      end

      describe 'with gt operator' do
        let(:params) { { filters: [{ property: 'age', operator: 'gt', values: [30] }] } }

        it "retrieves records with an age less than the specified value" do
          should_retrieve_records
          expect(json_response.pluck('id')).to include players(:veteran).id
          expect(json_response.pluck('id')).not_to include players(:young_guy).id
        end
      end

      describe 'with lt operator' do
        let(:params) { { filters: [{ property: 'age', operator: 'lt', values: [30] }] } }

        it "retrieves records with an age bigger than the specified value" do
          should_retrieve_records
          expect(json_response.pluck('id')).to include players(:young_guy).id
          expect(json_response.pluck('id')).not_to include players(:veteran).id
        end
      end

      describe 'with btw operator' do
        let(:params) { { filters: [{ property: 'age', operator: 'btw', values: [35, 45] }] } }

        it "retrieves records with an age within the specified range" do
          should_retrieve_records
          expect(json_response.pluck('id')).to include players(:veteran).id
          expect(json_response.pluck('id')).not_to include players(:young_guy).id
        end
      end
    end

    context 'when filtering by position' do
      describe 'with eq operator' do
        let(:player) { players(:test) }
        let(:params) { { filters: [{ property: 'position', operator: 'eq', values: [player.position]}] } }

        it "retrieves the records matching that position" do
          should_retrieve_records
          should_include_player
        end
      end
    end

    context 'when filtering by last_name' do
      describe 'with eq operator' do
        let(:player) { players(:test) }
        let(:params) { { filters: [{ property: 'last_name', operator: 'eq', values: [player.last_name]}] } }

        it "retrieves the records matching that last name" do
          should_retrieve_records
          should_include_player
        end
      end

      describe 'with match operator' do
        let(:player) { players(:test) }
        let(:params) { { filters: [{ property: 'last_name', operator: 'match', values: [player[0..3]]}] } }

        it "retrieves records with a last_name matching the search term" do
          should_retrieve_records
          should_include_player
        end
      end
    end

    context 'multiple filters' do
      describe 'filtering by age and position' do
        let(:player) { players(:test) }
        let(:params) do
          { filters: [
            { property: 'age', operator: 'eq', values: [player.age] },
            { property: 'last_name', operator: 'match', values: [player[0..3]]},
            { property: 'position', operator: 'eq', values: [player.position] }
          ]}
        end

        it 'still works 🤠' do
          should_retrieve_records
          should_include_player
        end
      end
    end
  end
end
