class User < ActiveRecord::Base
  has_many :friends, dependent: :destroy
  has_many :lists, dependent: :destroy
end
