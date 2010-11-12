require 'digest/sha1'

class Message < ActiveRecord::Base

  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :subject
  validates_presence_of :body
  validates_presence_of :lang

  attr_accessible :name, :email, :subject, :body, :friend, :lang
  
  before_create :make_activation_code

  def self.count_senders
    all(:conditions => ["active =  ?", true]).count
  end

  def self.count_messages
    data = connection.execute("SELECT SUM(cantidad) FROM (SELECT recipients.lang,COUNT(name) AS cantidad FROM messages, recipients WHERE messages.lang=recipients.lang AND active=1 GROUP BY lang) AS temp")
    total = data.to_a[0]

    return total.first.to_i
  end

  protected

  def make_activation_code
    self.activation_code = make_token
  end

  def make_token
    secure_digest(Time.now, (1..10).map { rand.to_s })
  end

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
end
