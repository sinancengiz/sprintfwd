require 'swagger_helper'

describe 'Teams' do
  let!(:team1) { Team.create(name: 'Test Team 1') }
  let!(:team2) { Team.create(name: 'Test Team 2') }
  let!(:team3) { Team.create(name: 'Test Team 3') }

  path "/api/v1/teams" do
    get 'Retrieve all teams' do
      tags 'Teams'
      produces 'application/json'

      response '200', 'Return information based on query' do

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(3)
          expect(data.empty?).to eq(false)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  path '/api/v1/teams/{id}' do

    get 'Retrieves a team' do
      tags 'Teams'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'team found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
          },
          required: [ 'id' ]

        let(:id) { Team.create(name: 'Test Team 4').id }
        run_test!
      end
    end
  end

  path '/api/v1/teams/{team_id}/members' do

    get 'Retrieves members of a team' do
      tags 'Teams'
      produces 'application/json', 'application/xml'
      parameter name: :team_id, in: :path, type: :string

      response '200', 'team found' do
        let(:team_id) { Team.create(name: 'Test Team 4').id }
        run_test!
      end
    end
  end

  path '/api/v1/teams' do
    post 'Creates a team' do
      tags 'Teams'
      consumes 'application/json'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
      }

      response '200', 'Created contact' do
        let!(:team) { Team.create(name: 'Test Team 4')  }
        run_test!
      end
    end
  end

  path "/api/v1/teams/{id}" do
    put 'Update team' do
      tags 'Teams'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
      }

      response '200', 'Updated Team' do
        let!(:team) { Team.create(name: 'Test Team 4')  }
        let!(:id) { team.id }
        run_test!
      end
    end
  end

  path "/api/v1/teams/{id}" do
    delete 'Delete a Team' do
      tags 'Teams'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true


      response '200', 'Return team deleted' do
        let!(:team) { Team.create(name: 'Test Team 4')  }
        let(:id) { team.id }
        run_test!
      end
    end
  end

end
