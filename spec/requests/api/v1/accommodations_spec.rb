require 'swagger_helper'

RSpec.describe 'API V1 - Accommodations', type: :request do
  path '/api/v1/accommodations' do
    get 'List all accommodations' do
      tags 'Accommodations'
      produces 'application/json'

      response '200', 'accommodations listed' do
        run_test!
      end
    end

    post 'Create a new accommodation' do
      tags 'Accommodations'
      consumes 'application/json'
      parameter name: :accommodation, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          price: { type: :number },
          location: { type: :string },
          type: { type: :string }
        },
        required: ['name', 'price', 'location', 'type']
      }

      response '201', 'accommodation created' do
        let(:accommodation) { { name: 'Flat 1', price: 250, location: 'downtown', type: 'Apartment' } }
        run_test!
      end
    end
  end

  path '/api/v1/accommodations/{id}' do
    get 'Get a specific accommodation' do
      tags 'Accommodations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'accommodation found' do
        let(:id) { Accommodation.create!(name: 'Flat 2', price: 300, location: 'montain', type: 'Hotel').id }
        run_test!
      end

      response '404', 'accommodation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
