class PagesController < ApplicationController

  def integrate
  end

  def stats
    @senders = Message.count_senders
  end
end
