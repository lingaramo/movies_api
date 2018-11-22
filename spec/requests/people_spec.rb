require 'rails_helper'

RSpec.describe "People" do
  let!(:person) { Fabricate(:person, alias: "person") }
  let!(:user) { User.create(email: "user@user.com", password: 12345678) }
  let(:json_response) { JSON.parse(response.body).with_indifferent_access }

  headers = {
    "ACCEPT" => "application/json",
  }

  def data_payload
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      "alias": Faker::Name.middle_name
    }
  end

  describe "#index" do
    before { get api_v1_people_path() }

    it "returns a list of people" do
      expect(json_response["data"][0]).to include(id: person.id.to_s)
    end
  end

  describe "#show" do
    before { get api_v1_person_path(person) }

    it "returns the requested person" do
      expect(json_response["data"]).to include(id: person.id.to_s)
    end
  end

  describe "#create" do
    describe "as anonymous user" do
      before do
        post api_v1_people_path(), params: data_payload
      end

      it "can't create new person" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do
      it "can create new person" do
        expect {
          post api_v1_people_path(), params: data_payload,
            headers: headers.merge(user.create_new_auth_token)
        }.to change(Person, :count).by(+1)
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#update" do
    describe "as anonymous user" do
      before do
        patch api_v1_person_path(person), params: data_payload
      end

      it "can't update person" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do

      it "can update person" do
        patch api_v1_person_path(person), params: params = data_payload,
        headers: headers.merge(user.create_new_auth_token)
        expect(JSON.parse(person.reload.to_json).with_indifferent_access).to include(params)
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#delete" do
    describe "as anonymous user" do
      before do
        delete api_v1_person_path(person)
      end

      it "can't delete movie" do
        expect(response.status).to eq(401)
      end
    end

    describe "as logged user" do

      it "can delete movie" do
        delete api_v1_person_path(person),
          headers: headers.merge(user.create_new_auth_token)

        expect{ person.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response.status).to eq(204)
      end
    end
  end
end
