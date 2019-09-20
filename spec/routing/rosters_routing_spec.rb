require "rails_helper"

RSpec.describe RostersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rosters").to route_to("rosters#index")
    end

    it "routes to #new" do
      expect(:get => "/rosters/new").to route_to("rosters#new")
    end

    it "routes to #show" do
      expect(:get => "/rosters/1").to route_to("rosters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rosters/1/edit").to route_to("rosters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rosters").to route_to("rosters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rosters/1").to route_to("rosters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rosters/1").to route_to("rosters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rosters/1").to route_to("rosters#destroy", :id => "1")
    end

    it "routes to #admin" do
      expect(:get => "/rosters/admin").to route_to("rosters#admin")
    end

    it "routes to #member" do
      expect(:get => "/rosters/member").to route_to("rosters#member")
    end

    it "routes to #import" do
      expect(:post => "/rosters/import").to route_to("rosters#import")
    end

    it "routes to #report" do
      expect(:get => "/rosters/1/patrol").to route_to("rosters#patrol", :id => "1")
    end
  end
end
