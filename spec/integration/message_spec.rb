require_relative '../../app'
require_relative '../../models/message'
require_relative '../../lib/messages_service'

require 'spec_helper.rb'


RSpec.describe "message", :type => :request do

  describe "get and post" do

    before :each do
    end

    it "returns hello.." do
      get "/"

      expect(last_response.body).to eq("<h3>Hello! This app build a web application which creates a text self-destructing messages.</h3>\n<br>\n<br>\n<br>\n<a href='/messages/new'>New message</a>\n")
      expect(last_response.status).to eq 200
    end

    it "get new message" do
      get "/messages/new"
      expect(last_response.status).to eq 200
    end

    it "post new message" do
      rnd_mess = Message.random_string(10)

      post "/messages/new", message: rnd_mess, expires_after: 1, click_exp: 0, time_exp:0
      last_response.should be_redirect
      last_response.location.should include '/messages'
    end

    it "get messages" do
      get "/messages"
      expect(last_response.status).to eq 200
    end

    it "get one message" do
      get "/messages/:uid", uid: 1234567890
      expect(last_response.status).to eq 200
    end
  end
end
