class Tweet < ApplicationRecord

    belongs_to :user
    belongs_to :organization
    validates :message, presence: true
    validates_associated :organization, :user

end
