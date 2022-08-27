

class InstructorsController < ApplicationController
    def index
        instructors = Instructor.all
        render json: instructors
    rescue ActiveRecord::RecordNotFound
        record_not_found_response
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    rescue ActiveRecord::RecordNotFound
        record_not_found_response
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
      
    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        record_not_found_response

    end


    private

    def record_not_found_response
        render json: {error: "Instructor Not Found"}, status: :not_found
    end

    def instructor_params
        params.permit(:name)
    end

end
