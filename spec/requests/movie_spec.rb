require 'rails_helper'

RSpec.describe "Movies" do
  let!(:movie) { Fabricate(:movie) }
  let!(:user) { User.create(email: "user@user.com", password: 12345678) }
  let(:json_response) { JSON.parse(response.body).with_indifferent_access }

  headers = {
    "ACCEPT" => "application/json",
  }

  def data_payload
    {
      title: Faker::Lorem.sentence,
      release_year: (1901 + rand(118))
    }
  end

  describe "#index" do
    before { get api_v1_movies_path() }

    it "returns a list of movies" do
      expect(json_response["data"][0]).to include(id: movie.id.to_s)
    end
  end

  describe "#show" do
    before { get api_v1_movie_path(movie) }

    it "returns the requested movie" do
      expect(json_response["data"]).to include(id: movie.id.to_s)
    end
  end

  describe "#create" do
    describe "as anonymous user" do
      before do
        post api_v1_movies_path(), params: data_payload
      end

      it "can't create new movie" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do
      it "can create new movie" do
        expect {
          post api_v1_movies_path(), params: data_payload,
            headers: headers.merge(user.create_new_auth_token)
        }.to change(Movie, :count).by(+1)
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#update" do
    describe "as anonymous user" do
      before do
        patch api_v1_movie_path(movie), params: data_payload
      end

      it "can't update movie" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do

      it "can update movie" do
        patch api_v1_movie_path(movie), params: params = data_payload,
        headers: headers.merge(user.create_new_auth_token)
        expect(JSON.parse(movie.reload.to_json).with_indifferent_access).to include(params)
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#delete" do
    describe "as anonymous user" do
      before do
        delete api_v1_movie_path(movie)
      end

      it "can't delete movie" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do

      it "can delete movie" do
        delete api_v1_movie_path(movie),
          headers: headers.merge(user.create_new_auth_token)

        expect{ movie.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response.status).to eq(204)
      end
    end
  end

  let!(:actor) { Fabricate(:person, alias: "actor") }
  let!(:director) { Fabricate(:person, alias: "director") }
  let!(:producer) { Fabricate(:person, alias: "producer") }
  describe "adding crew members" do
    describe "casting" do
      describe "as anonymous user" do
        before do
          post add_actor_api_v1_movie_path(movie), params: {person_id: actor.id}
        end

        it "can't add actor to movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can add actor" do
          expect {
            post add_actor_api_v1_movie_path(movie), params: {person_id: actor.id},
              headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.casting, :count).by(+1)
          expect(movie.reload.casting).to include(actor)
          expect(response.status).to eq(200)
        end
      end
    end

    describe "directors" do
      describe "as anonymous user" do
        before do
          post add_director_api_v1_movie_path(movie), params: {person_id: director.id}
        end

        it "can't add director to movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can add director" do
          expect {
            post add_director_api_v1_movie_path(movie), params: {person_id: director.id},
            headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.directors, :count).by(+1)
          expect(movie.reload.directors).to include(director)
          expect(response.status).to eq(200)
        end
      end
    end

    describe "producers" do
      describe "as anonymous user" do
        before do
          post add_producer_api_v1_movie_path(movie), params: {person_id: producer.id}
        end

        it "can't add director to movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can add director" do
          expect {
            post add_producer_api_v1_movie_path(movie), params: {person_id: producer.id},
            headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.producers, :count).by(+1)
          expect(movie.reload.producers).to include(producer)
          expect(response.status).to eq(200)
        end
      end
    end
  end

  describe "removing crew members" do
    before do
      movie.casting.push(actor)
      movie.directors.push(director)
      movie.producers.push(producer)
    end

    describe "#remove_actor" do
      describe "as anonymous user" do
        before do
          delete remove_actor_api_v1_movie_path(movie), params: {person_id: actor.id}
        end

        it "can't remove actor from movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can remove actor from movie" do
          expect(movie.casting).to include(actor)
          expect {
            delete remove_actor_api_v1_movie_path(movie), params: {person_id: actor.id},
              headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.casting, :count).by(-1)
          expect(movie.reload.casting).not_to include(actor)
        end
      end
    end


    describe "#remove_director" do
      describe "as anonymous user" do
        before do
          delete remove_director_api_v1_movie_path(movie), params: {person_id: director.id}
        end

        it "can't remove director from movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can remove director from movie" do
          expect(movie.directors).to include(director)
          expect {
            delete remove_director_api_v1_movie_path(movie), params: {person_id: director.id},
              headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.directors, :count).by(-1)
          expect(movie.reload.casting).not_to include(director)
        end
      end
    end

    describe "#remove_producer" do
      describe "as anonymous user" do
        before do
          delete remove_producer_api_v1_movie_path(movie), params: {person_id: producer.id}
        end

        it "can't remove producer from movie" do
          expect(response.status).to eq(401)
        end
      end

      describe "as logged user" do
        it "can remove producer from movie" do
          expect(movie.producers).to include(producer)
          expect {
            delete remove_producer_api_v1_movie_path(movie), params: {person_id: producer.id},
              headers: headers.merge(user.create_new_auth_token)
          }.to change(movie.producers, :count).by(-1)
          expect(movie.reload.casting).not_to include(producer)
        end
      end
    end
  end
end
