class Domain < ApplicationRecord
  has_many :notifications
  has_many :checking_logs
end
