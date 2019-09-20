require "rails_helper"

RSpec.describe ClubsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/clubs").to route_to("clubs#index")
    end

    it "routes to #new" do
      expect(:get => "/clubs/new").to route_to("clubs#new")
    end

    it "routes to #show" do
      expect(:get => "/clubs/1").to route_to("clubs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/clubs/1/edit").to route_to("clubs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clubs").to route_to("clubs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/clubs/1").to route_to("clubs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/clubs/1").to route_to("clubs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clubs/1").to route_to("clubs#destroy", :id => "1")
    end

    it "routes to #admin" do
      expect(:get => "/clubs/admin").to route_to("clubs#admin")
    end
  end
end
