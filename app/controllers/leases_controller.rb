class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create 
        lease = Lease.create(lease_new_params) 
        render json: lease
    end 

    def destroy 
        lease = lease_params 
        lease.destroy 
        head :no_content
    end

    private 
    def lease_params 
        lease.find(params[:id])
    end
    def Lease_new_params
        params.permit(:name) 
    end

    def render_not_found_response
        render json: { error: "lease not found" }, status: :not_found
      end

      def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
      end
end
