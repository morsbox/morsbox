class ContactMessage < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true,
                    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :message, :presence => true, :length => { :maximum => 10.kilobytes }
end
