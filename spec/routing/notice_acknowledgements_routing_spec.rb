require "rails_helper"

RSpec.describe NoticeAcknowledgementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/notice_acknowledgements").to route_to("notice_acknowledgements#index")
    end

    it "routes to #new" do
      expect(:get => "/notice_acknowledgements/new").to route_to("notice_acknowledgements#new")
    end

    it "routes to #show" do
      expect(:get => "/notice_acknowledgements/1").to route_to("notice_acknowledgements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/notice_acknowledgements/1/edit").to route_to("notice_acknowledgements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/notice_acknowledgements").to route_to("notice_acknowledgements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/notice_acknowledgements/1").to route_to("notice_acknowledgements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/notice_acknowledgements/1").to route_to("notice_acknowledgements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/notice_acknowledgements/1").to route_to("notice_acknowledgements#destroy", :id => "1")
    end
  end
end
