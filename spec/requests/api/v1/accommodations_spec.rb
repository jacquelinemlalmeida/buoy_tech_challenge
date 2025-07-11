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
        let(:accommodation) { { name: 'Flat 1', price: 250.00, location: 'downtown', type: 'Apartment' } }
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
        let(:id) { Accommodation.create!(name: 'Flat 2', price: 300.00, location: 'montain', type: 'Hotel').id }
        run_test!
      end

      response '404', 'accommodation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Update an accommodation' do
      tags 'Accommodations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :accommodation, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          price: { type: :number },
          location: { type: :string },
          type: { type: :string }
        }
      }

      response '200', 'accommodation updated' do
        let(:id) { Accommodation.create!(name: 'Update Me', price: 200.00, location: 'UpdateTown', type: 'Apartment').id }
        let(:accommodation) { { name: 'Updated Flat' } }
        run_test!
      end
    end

    delete 'Delete an accommodation' do
      tags 'Accommodations'
      parameter name: :id, in: :path, type: :string

      response '204', 'accommodation deleted' do
        let(:id) { Accommodation.create!(name: 'To Delete', price: 100.00, location: 'OldCity', type: 'Hotel').id }
        run_test!
      end
    end

    path '/api/v1/accommodations/{id}/next_available_date' do
      get 'Get next available date for an accommodation' do
        tags 'Accommodations'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :date, in: :query, type: :string, format: :date, required: false, description: 'Start date to search from'

        response '200', 'next available date returned' do
          let(:id) { Accommodation.create!(name: 'Flat 4', price: 400.00, location: 'Vista', type: 'Apartment').id }
          let(:date) { (Date.today + 1).to_s }
          run_test!
        end

        response '404', 'accommodation not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '400', 'bad request' do
          let(:id) { Accommodation.create!(name: 'Flat 4', price: 400.00, location: 'Vista', type: 'Apartment').id }
          let(:date) { (Date.today - 10.days).to_s }
          run_test!
        end
      end
    end
  end
end
