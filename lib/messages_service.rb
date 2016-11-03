class MessagesService

  def self.add_message(host, msg, params={})
    # generate uid
    uid = Message.generate_message_uid
    # generate link
    link = get_link(host, uid)
    # encrypt message
    key, iv, cipher_text = EncryptDecrypt.for_encrypt(msg)
    #
    expiries = params[:expires].to_i
    click_exp = params[:click_exp].to_i
    time_exp = params[:time_exp].to_i

    row = Message.new(message: cipher_text, uid: uid, key:key, iv: iv, link: link)

    check_for_expiries(row, expiries, click_exp, time_exp)
=begin
    if click_exp > 0 && time_exp >= 0
      row.visit_total = click_exp
      row.visit_count = 1
      row.expires_at = Message::TIME_NOW + 10**5
    elsif time_exp > 0 && click_exp == 0
      row.expires_at = Message::TIME_NOW + time_exp.hours
    elsif expiries > 0 && click_exp == 0 && time_exp == 0
      if expiries == 1
        row.visit_total = expiries
        row.visit_count = expiries
        row.expires_at = Message::TIME_NOW + 10**5
      elsif expiries == 3600 && time_exp == 0
        row.expires_at = Message::TIME_NOW + 1.hours
      end
    end
=end
    row.save!
  end

  def self.check_for_expiries(row, expiries, click_exp, time_exp)
    if click_exp > 0 && time_exp >= 0
      row.visit_total = click_exp
      row.visit_count = 1
      row.expires_at = Message::TIME_NOW + 10**5
    elsif time_exp > 0 && click_exp == 0
      row.expires_at = Message::TIME_NOW + time_exp.hours
    elsif expiries > 0 && click_exp == 0 && time_exp == 0
      if expiries == 1
        row.visit_total = expiries
        row.visit_count = expiries
        row.expires_at = Message::TIME_NOW + 10**5
      elsif expiries == 3600 && time_exp == 0
        row.expires_at = Message::TIME_NOW + 1.hours
      end
    end
  end

  def self.get_messages
    rows = Message.expired_actual.visit_actual.get_list
    rows
  end

  def self.get_link(host,msg_uid)
    "http://"+host+"/message/#{msg_uid}"
  end

  def self.get_message_by_uid(uid)
    msg = Message.get_by_uid(uid)
    if msg
      if msg.expires_at < Message::TIME_NOW || msg.visit_count > msg.visit_total
        msg.destroy!
        return nil, "This message will self-destruct, please, create a new message"
      else
        if msg.visit_total == 0
          # decrypt message
          message = EncryptDecrypt.for_decrypt(msg.key, msg.iv, msg.message)
          return [msg, message]
        elsif msg.visit_total > 0
          msg.visit_count += 1
          msg.save!
          message = EncryptDecrypt.for_decrypt(msg.key, msg.iv, msg.message)
          return [msg, message]
        end
      end
    else
      return nil, "Message not found"
    end
  end

end
