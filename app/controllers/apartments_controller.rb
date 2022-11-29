class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        render json: Apartment.all
    end 
    def show 
        apartment = apartment_params 
        render json: apartment
    end 
    def create 
        apartment = Apartment.create(apartment_new_params) 
        render json: apartment
    end 
    def update 
        apartment = apartment_params 
        apartments = apartment.update(apartment_new_params) 
        render json: apartments
    end
    def destroy 
        apartment = apartment_params 
        apartment.destroy 
        head :no_content
    end

    private 
    def apartment_params 
        Apartment.find(params[:id])
    end
    def apartment_new_params
        params.permit(:name) 
    end

    def render_not_found_response
        render json: { error: "apartment not found" }, status: :not_found
      end

      def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
      end
end
