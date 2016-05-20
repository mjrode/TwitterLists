class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friends, dependent: :destroy
  has_many :lists, dependent: :destroy
end
