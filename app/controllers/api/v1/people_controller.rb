class Api::V1::PeopleController < ApplicationController
  def index
    people = PersonSerializer.new(Person.all).serialized_json
    render json: people
  end

  def create
    person = Person.new(permited_attributes)
    if person.save
      render json: PersonSerializer.new(person).serialized_json
    else
      respond_with_errors(person)
    end
  end

  def show
    person = Person.find(params[:id])
    render json: PersonSerializer.new(person).serialized_json
  end

  def update
    person = Person.find(params[:id])
    if person.update(permited_attributes)
      render json: PersonSerializer.new(person).serialized_json
    else
      respond_with_errors(person)
    end
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    head :no_content
  end

  private

  def permited_attributes
    params.permit([:first_name, :last_name, :alias])
  end
end
