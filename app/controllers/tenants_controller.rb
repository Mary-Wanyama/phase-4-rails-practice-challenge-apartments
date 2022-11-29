class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        render json: Tenant.all
    end 
    def show 
        tenant = tenant_params 
        render json: tenant
    end 
    def create 
        tenant = Tenant.create(tenant_new_params) 
        render json: tenant
    end 
    def update 
        tenant = tenant_params 
        tenants = tenant.update(tenant_new_params) 
        render json: tenants
    end
    def destroy 
        tenant = tenant_params 
        tenant.destroy 
        head :no_content
    end

    private 
    def tenant_params 
        Tenant.find(params[:id])
    end
    def tenant_new_params
        params.permit(:name) 
    end

    def render_not_found_response
        render json: { error: "tenant not found" }, status: :not_found
      end

      def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
      end
end
