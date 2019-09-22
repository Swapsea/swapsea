require "rails_helper"

RSpec.describe OutreachPatrolSignUpsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/outreach_patrol_sign_ups").to route_to("outreach_patrol_sign_ups#index")
    end

    it "routes to #new" do
      expect(:get => "/outreach_patrol_sign_ups/new").to route_to("outreach_patrol_sign_ups#new")
    end

    it "routes to #show" do
      expect(:get => "/outreach_patrol_sign_ups/1").to route_to("outreach_patrol_sign_ups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/outreach_patrol_sign_ups/1/edit").to route_to("outreach_patrol_sign_ups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/outreach_patrol_sign_ups").to route_to("outreach_patrol_sign_ups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/outreach_patrol_sign_ups/1").to route_to("outreach_patrol_sign_ups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/outreach_patrol_sign_ups/1").to route_to("outreach_patrol_sign_ups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/outreach_patrol_sign_ups/1").to route_to("outreach_patrol_sign_ups#destroy", :id => "1")
    end
  end
end
