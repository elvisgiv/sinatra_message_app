
get '/' do
  haml :'messages/home.html'
  #'hello, world'
  #redirect '/messages/new'
end


get '/messages/new' do
  @one_hour = 3600#seconds
  @one_click = 1

  haml :'messages/new.html'
end

post '/messages/new' do
  require_relative '../lib/messages_service'
  #
  msg = params['message'] || ''
  expires = params['expires_after'] || 0
  click_exp = params['click_exp'] || 0
  time_exp = params['time_exp'] || 0
  #
  host = request.host
  params = {click_exp: click_exp, expires: expires, time_exp: time_exp}
  # work
  @message = MessagesService.add_message(host, msg, params)
  #
  redirect '/messages'
end

get '/messages' do
  require_relative '../lib/messages_service'
  # work
  @messages = MessagesService.get_messages
  #
  haml :'/messages/index.html'
end

get '/messages/:uid' do
  require_relative '../lib/messages_service'
  require 'date'
  #
  uid = params[:uid] || ''
  # work
  @msg_obj, @message = MessagesService.get_message_by_uid(uid)
  if @msg_obj
    @expires_click = @msg_obj.visit_total.to_i - @msg_obj.visit_count.to_i + 1
    exp = @msg_obj.expires_at
    @expires_after = ((exp - Message::TIME_NOW.utc)).to_i
  end
  #
  haml :'messages/show.html'
end