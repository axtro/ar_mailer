##
# Adds sending email through an ActiveRecord table as a delivery method for
# ActionMailer.
#

class ARMailer
    
  def initialize(options)
    self.email_class = options[:email_class] || Email
  end
  
  attr_accessor :email_class_name, :email_class
  
  def deliver!(mail)
    destinations = mail.destinations
    sender = mail.return_path || mail.sender || mail.from_addrs.first
    destinations.each do |destination|
      self.email_class.create :mail => mail.encoded, :to => destination, :from => sender
    end
  end
end
