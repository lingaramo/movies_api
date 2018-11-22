class Api::V1::PeopleController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    people = PersonSerializer.new(Person.all).serialized_json
    render json: people
  end

  def create
    person = Person.new(permited_attributes)
    if person.save
      render json: serialize_person(person)
    else
      respond_with_errors(person)
    end
  end

  def show
    person = Person.find(params[:id])
    render json: serialize_person(person)
  end

  def update
    person = Person.find(params[:id])
    if person.update(permited_attributes)
      render json: serialize_person(person)
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

  def serialize_person(object)
    options = {}
    options[:include] = [:as_actor, :as_director, :as_producer]
    PersonSerializer.new(object, options).serialized_json
  end
end
