require 'swagger_helper'

describe 'Members' do
  let!(:team) { Team.create(name: 'Test Team 1') }
  let!(:member1) { Member.create(first_name: 'Test Member 1', last_name: "Test last name", team_id: team.id) }
  let!(:member2) { Member.create(first_name: 'Test Member 1', last_name: "Test last name", team_id: team.id) }
  let!(:member3) { Member.create(first_name: 'Test Member 1', last_name: "Test last name", team_id: team.id) }

  path "/api/v1/members" do
    get 'Retrieve all members' do
      tags 'Members'
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

  path '/api/v1/members/{id}' do

    get 'Retrieves a member' do
      tags 'Members'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'member found' do
        schema type: :array,
          properties: {
            id: { type: :integer },
          },
          required: [ 'id' ]

        let(:id) { Member.create(first_name: 'Test Member 4').id }
        run_test!
      end
    end
  end

  path '/api/v1/members' do
    post 'Creates a member' do
      tags 'Members'
      consumes 'application/json'
      parameter name: :member, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          city: { type: :string },
          state: { type: :string },
          country: { type: :string },
          team_id: { type: :integer },
        },
      }

      response '200', 'Created member' do
        let!(:member) { Member.create(first_name: 'Test Member 4', last_name: "last name", team_id: team.id)  }
        run_test!
      end
    end
  end

  path "/api/v1/members/{id}" do
    put 'Update member' do
      tags 'Members'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :member, in: :body, schema: {
        type: :object,
        properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            city: { type: :string },
            state: { type: :string },
            country: { type: :string },
            team_id: { type: :integer },
        },
      }

      response '200', 'Updated member' do
        let!(:member) { Member.create(first_name: 'Test member 4', last_name: "last name", team_id: team.id)  }
        let!(:id) { member.id }
        run_test!
      end
    end
  end

  path "/api/v1/members/{member_id}/update_team/{team_id}" do
    put 'Update team of a member' do
      tags 'Members'
      consumes 'application/json'
      parameter name: :member_id, in: :path, type: :integer, required: true
      parameter name: :team_id, in: :path, type: :integer, required: true
      
      response '200', 'Updated member' do
        let!(:member) { Member.create(first_name: 'Test member 4', last_name: "last name", team_id: team.id)  }
        let!(:team2) { Team.create(name: 'Test Team 2') }
        let!(:member_id) { member.id }
        let!(:team_id) { team2.id }
        run_test!
      end
    end
  end

  path "/api/v1/members/{id}" do
    delete 'Delete a member' do
      tags 'Members'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true


      response '200', 'Return member deleted' do
        let!(:member) { Member.create(first_name: 'Test Member 4', last_name: "last name", team_id: team.id)  }
        let(:id) { member.id }
        run_test!
      end
    end
  end

end
