class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true, uniqueness: {case_sensitive: false},
             length: {minimum: 3, maximum: 10}
  VALID_EMAIL_REGEX = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/ 
  validates :email, presence: true,uniqueness: {case_sensitive: false},
             length: {maximun: 105}, format: {with: VALID_EMAIL_REGEX}
end
