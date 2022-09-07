class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index
        scientists = Scientist.all 
        render json:scientists, status: :ok 
    end
    
    def show 
        scientist = Scientist.find(params[:id])
        render json:scientist, serializer: ScientistWithPlanetsSerializer
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json:scientist, status: :created
    end
    
    def update
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json:scientist, status: :accepted
    end

    def destroy 
        scientist = Scientist.find(params[:id])
        scientist.destroy
        head :no_content
    end

    private 
    def not_found(exception)
        render json: {error: "#{exception.model} not found"},status: :not_found
    end
    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    

    def scientist_params
        params.permit(:name, :field_of_study,:avatar)
    end

    
end
