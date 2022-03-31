require 'swagger_helper'

describe 'projects' do
  let!(:project1) { Project.create(name: 'Test project 1') }
  let!(:project2) { Project.create(name: 'Test project 2') }
  let!(:project3) { Project.create(name: 'Test project 3') }

  path "/api/v1/projects" do
    get 'Retrieve all projects' do
      tags 'Projects'
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

  path "/api/v1/projects/{project_id}/members" do
    get 'Retrieve all members of a project' do
      tags 'Projects'
      produces 'application/json'
      parameter name: :project_id, in: :path, type: :string

      response '200', 'Return information based on query' do
        let(:team) { Team.create(name: 'Test team ') }
        let(:project) { Project.create(name: 'Test project 4') }
        let(:member) { Member.create(first_name: 'Test member', last_name:"last name", team_id: team.id).id }
        let(:project_member) {ProjectMember.create(project_id: project.id, member_id: member.id)} 
        let(:project_id) {:project.id}
        let(:member_id) {:member.id}
        run_test! 
      end
    end
  end

  path '/api/v1/projects/{id}' do

    get 'Retrieves a project' do
      tags 'Projects'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'project found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
          },
          required: [ 'id' ]

        let(:id) { Project.create(name: 'Test project 4').id }
        run_test!
      end
    end
  end

  path '/api/v1/projects' do
    post 'Creates a project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
      }

      response '200', 'Created contact' do
        let!(:project) { Project.create(name: 'Test project 4')  }
        run_test!
      end
    end
  end

  path '/api/v1/projects/{project_id}/members/{member_id}' do
    post 'Add a member to a project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :project_id, in: :path, type: :string
      parameter name: :member_id, in: :path, type: :string

      response '200', 'Created contact' do
        let(:team) { Team.create(name: 'Test team ') }
        let(:project) { Project.create(name: 'Test project 4') }
        let(:member) { Member.create(first_name: 'Test member', last_name:"last name", team_id: team.id).id }
        let(:project_member) {ProjectMember.create(project_id: project.id, member_id: member.id)} 
        let(:project_id) {:project.id}
        let(:member_id) {:member.id}
        run_test!
      end
    end
  end

  path "/api/v1/projects/{id}" do
    put 'Update project' do
      tags 'Projects'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
      }

      response '200', 'Updated project' do
        let!(:project) { Project.create(name: 'Test project 4')  }
        let!(:id) { project.id }
        run_test!
      end
    end
  end

  path "/api/v1/projects/{id}" do
    delete 'Delete a project' do
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true


      response '200', 'Return project deleted' do
        let!(:project) { Project.create(name: 'Test project 4')  }
        let(:id) { project.id }
        run_test!
      end
    end
  end

end
