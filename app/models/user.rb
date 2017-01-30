class User < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  has_many :wishlists
  has_many :properties
  enum kind: [ :user, :admin ]
end
