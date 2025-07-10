module Api
  module V1
    class AccommodationsController < ApplicationController
      before_action :set_accommodation, only: %i[show update destroy]

      def index
        accommodations = Accommodation.all
        render json: accommodations
      end

      def show
        render json: @accommodation
      end

      def create
        accommodation = Accommodation.new(accommodation_params)
        if accommodation.save
          render json: accommodation, status: :created
        else
          render json: accommodation.errors, status: :unprocessable_entity
        end
      end

      def update
        if @accommodation.update(accommodation_params)
          render json: @accommodation
        else
          render json: @accommodation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @accommodation.destroy
        head :no_content
      end

      def next_available_date
        accommodation = Accommodation.find_by(id: params[:id])
        return render json: { }, status: :not_found unless accommodation

        from_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
        if from_date < Date.today
          return render json: { error: 'Date must be today or in the future' }, status: :bad_request
        end
        next_date = accommodation.next_available_date(from_date)

        render json: { next_available_date: next_date }, status: :ok
      rescue ArgumentError
        render json: { error: 'Invalid date format' }, status: :bad_request
      end

      private

      def set_accommodation
        @accommodation = Accommodation.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { }, status: :not_found
      end

      def accommodation_params
        params.require(:accommodation).permit(:name, :description, :price, :location, :type)
      end
    end
  end
end
