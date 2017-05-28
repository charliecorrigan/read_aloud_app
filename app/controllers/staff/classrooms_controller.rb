class Staff::ClassroomsController < Staff::BaseController
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

  def update
    @classroom = Classroom.find(params[:id])
    if @classroom.update(classroom_params)
      redirect_to staff_school_path(@classroom.school)
    else
      render :edit
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    school = @classroom.school
    @classroom.destroy
    redirect_to staff_school_path(school)
  end

  private

  def classroom_params
    params.require(:classroom).permit(:teacher_name, :grade_level, :number_of_students_enrolled)
  end
end
