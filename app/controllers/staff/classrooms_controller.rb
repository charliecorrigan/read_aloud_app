class Staff::ClassroomsController < ApplicationController
  def new
    @classroom = Classroom.new
  end
end
