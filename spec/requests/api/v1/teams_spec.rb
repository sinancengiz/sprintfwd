require 'swagger_helper'

describe 'Teams' do

  path '/api/v1/teams' do

    post 'Creates a team' do
      tags 'Teams'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
        required: [ 'name']
      }

      response '201', 'team created' do
        let(:team) { { name: 'Test team' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:team) { { name_first: 'foo' } }
        run_test!
      end
    end
  end

  path '/blogs/{id}' do

    get 'Retrieves a blog' do
      tags 'Blogs', 'Another Tag'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'blog found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            content: { type: :string }
          },
          required: [ 'id', 'title', 'content' ]

        let(:id) { Blog.create(title: 'foo', content: 'bar').id }
        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
