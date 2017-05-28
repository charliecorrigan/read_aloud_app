class Staff::SchoolsController < Staff::BaseController

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to staff_school_path(@school)
    else
      render :new
    end
  end

  def show
    @school = School.find(params[:id])
    session[:current_school_id] = @school.id
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      redirect_to staff_school_path(@school)
    else
      render :edit
    end
  end

  def destroy
    school = School.find(params[:id])
    school.destroy
    redirect_to staff_schools_path
  end

  private

  def school_params
    params.require(:school).permit(:name, :address)
  end
end
