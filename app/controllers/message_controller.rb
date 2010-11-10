class MessageController < ApplicationController

  def index
    @message = Message.new
  end

  def send_message
    if params[:message] != nil
      if params[:message][:email] != nil
        message = Message.find_by_email(params[:message][:email], :conditions => ["active = ?", true])
        if message
          flash[:error] = t(:you_cant_send_more_messages)
          redirect_to message_path
          return
        end
      else
        flash[:error] = t(:you_need_to_fill_your_email)
        redirect_to message_path
        return
      end
    end

    @message = Message.new(params[:message])
    @message.remote_ip = request.remote_ip
    @message.lang = I18n.locale

    if @message.save
      Mailman.send_activation_code(@message).deliver
      flash[:notice] = t(:follow_instructions_that_we_send_to_your_email_check_spam_folder)
      redirect_to message_path
    else
      flash[:error] = t(:check_the_red_fields)
      render :action => :index
    end
  end
  
  def activate
    message = Message.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    if message
      message.active = true
      message.activation_code = nil
      message.save
      flash[:notice] = t(:your_message_will_be_sent)
      redirect_to message_path
    else
      flash[:error] = t(:we_did_not_find_the_message_with_that_activation_code)
      redirect_to message_path
    end
  end
end

