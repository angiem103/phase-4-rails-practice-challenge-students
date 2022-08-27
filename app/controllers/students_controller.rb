class StudentsController < ApplicationController
    def index
        students = Student.all
        render json: students
    rescue ActiveRecord::RecordNotFound
        record_not_found_response
    end

    def show
        student = Student.find(params[:id])
        render json: student
    rescue ActiveRecord::RecordNotFound
        record_not_found_response
    end

    def create
        student = Student.create!(student_params)
        byebug
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def update
        student = Student.find_by(id: params[:id])
        student.update!(student_params)
        render json: student
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
      
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        record_not_found_response

    end


    private

    def record_not_found_response
        render json: {error: "Student Not Found"}, status: :not_found
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end


end
