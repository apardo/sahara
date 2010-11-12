class PagesController < ApplicationController

  def integrate
  end

  def stats
    @senders = Message.count_senders
    @messages = Message.count_messages
  end
end
