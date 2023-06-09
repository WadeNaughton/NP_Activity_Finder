class User < ApplicationRecord
  validates_presence_of :password_digest, presence: true
  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true
  validates_presence_of :username, presence: true, uniqueness: true
  validates_presence_of :state, presence: true

  has_secure_password

  has_many :user_new_parks
  has_many :new_parks, through: :user_new_parks

  has_many :user_new_events
  has_many :new_events, through: :user_new_events

  has_many :comments, through: :user_new_events
end
