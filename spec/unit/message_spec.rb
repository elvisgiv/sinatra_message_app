require_relative '../../app'
require_relative '../../models/message'
require_relative '../../lib/messages_service'

require 'spec_helper.rb'


RSpec.describe "message", :type => :request do

  describe "get and post" do

    before :each do

    end

    it 'add row to table messages' do
      host = "any_host"
      msg = Message.random_string(10)
      params = {expires_after: 1, click_exp: 0, time_exp:0}
      # work and exept
      expect{
        res = MessagesService.add_message(host, msg, params)
      }.to change{Message.count}.by(1)
    end

    it "get by uid" do
      #prepare
      msg = Message.random_string(10)
      uid = "123456789"
      msg = Message.new(message: msg, uid: uid)
      msg.save
      #work
      msg_from_db = Message.get_by_uid(uid)
      #
      expect(msg_from_db.uid).to eq uid
    end

  end
end
