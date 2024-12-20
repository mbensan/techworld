class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  before_action :only_instructor, except: %i[show index]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    query_in = "select u.id, u.name from users u join enrollments e on u.id = e.user_id where e.course_id = #{params[:id]} and u.role = 'estudiante'"
    @students_in = User.find_by_sql(query_in)
    
    query_out = "select id, name from users where id not in 
                  (select u.id from users u
                  join enrollments e on u.id = e.user_id 
                  where e.course_id = #{params[:id]}
                  ) and role = 'estudiante'"
    @students_out = User.find_by_sql(query_out)
    
    puts(@students_out)
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  def add_student
  end

  def remove_student
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :duration)
    end
end
