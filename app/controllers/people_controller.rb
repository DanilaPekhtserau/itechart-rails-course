# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :redirect_to_sign_up
  before_action :require_needed_signed_user, only: %i[edit destroy update]
  def index
    @people = Person.where(user: current_user)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user
    @person.save
    redirect_to people_path
  end

  def edit
    @person = Person.find_by id: params[:id]
  end

  # @todo refactor
  def update
    @person = Person.find_by id: params[:id]
    if @person.update(person_params)
      redirect_to people_path
    else
      render :edit
    end
  end

  def destroy
    @person = Person.find_by id: params[:id]
    if Person.all.length == 1
      flash[:notice] = 'Нельзя удалять последнюю персону.'
    else
      @person.destroy
    end
    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(:name)
  end

  def require_needed_signed_user
    person = Person.find(params[:id])
    return if current_user == person.user

    redirect_to root_path
  end
end
