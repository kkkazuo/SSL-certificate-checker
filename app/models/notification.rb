class Notification < ApplicationRecord
  belongs_to :domain
  enum certificate_type: [:digital, :intermediate, :root]
end
