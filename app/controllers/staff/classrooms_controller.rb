class Staff::ClassroomsController < ApplicationController
  def new
    @classroom = Classroom.new
  end

  def create
    school = School.find(session[:current_school_id])
    @classroom = school.classrooms.new(classroom_params)
    if @classroom.save
      redirect_to staff_school_path(school)
    else
      render :new
    end
  end

  def edit
    @classroom = Classroom.find(params[:id])
  end

  private

  def classroom_params
    params.require(:classroom).permit(:teacher_name, :grade_level, :number_of_kids_enrolled)
  end
end
