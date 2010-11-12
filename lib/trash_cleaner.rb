class TrashCleaner

  def self.remove_stale_sessions
    ActiveRecord::SessionStore::Session.
      destroy_all( ["updated_at < ?", 3.hour.ago] )
  end

  def self.remove_spam_messages
    Message.destroy_all( ["created_at < ? AND active = ?", 24.hour.ago, false] )
  end
end

