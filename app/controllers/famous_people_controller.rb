class FamousPeopleController < ApplicationController
  def index
    @famous_people = FamousPerson.all
  end

  def new
    @famous_person = FamousPerson.new
  end

  def create
    @famous_person = FamousPerson.new(famous_person_params)
    if @famous_person.save
      flash[:success] = 'People created!'
      redirect_to famous_people_path
    else
      flash[:danger] = "Create fail"
      render 'new'
    end
  end

  private

  def famous_person_params
    params.require(:famous_person).permit(:photo, :full_name, :real_name, :birthday)
  end
end
