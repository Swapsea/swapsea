require "rails_helper"

RSpec.describe ProficiencySignupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/proficiency_signups").to route_to("proficiency_signups#index")
    end

    it "routes to #new" do
      expect(:get => "/proficiency_signups/new").to route_to("proficiency_signups#new")
    end

    it "routes to #show" do
      expect(:get => "/proficiency_signups/1").to route_to("proficiency_signups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/proficiency_signups/1/edit").to route_to("proficiency_signups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/proficiency_signups").to route_to("proficiency_signups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/proficiency_signups/1").to route_to("proficiency_signups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/proficiency_signups/1").to route_to("proficiency_signups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/proficiency_signups/1").to route_to("proficiency_signups#destroy", :id => "1")
    end
  end
end
