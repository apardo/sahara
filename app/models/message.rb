require 'digest/sha1'

class Message < ActiveRecord::Base

  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :subject
  validates_presence_of :body

  attr_accessible :name, :email, :subject, :body, :friend
  
  before_create :make_activation_code


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
