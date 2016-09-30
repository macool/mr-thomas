require 'securerandom'

class Subscriber
  include Mongoid::Document

  field :name
  field :host
  field :token
  field :recipient

  index(
    { token: 1 },
    { unique: true }
  )

  has_many :notifications

  validates :token,
            presence: true,
            uniqueness: true
  validates :name,
            :host,
            :recipient,
            presence: true

  before_validation :generate_token!,
                    if: :new_record?

  def generate_token!
    self.token = SecureRandom.hex
  end
end
