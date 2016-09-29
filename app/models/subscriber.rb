require 'securerandom'

class Subscriber
  include Mongoid::Document

  field :token

  index(
    { token: 1 },
    { unique: true }
  )

  validates :token,
            presence: true,
            uniqueness: true

  before_validation :generate_token!,
                    if: :new_record?

  def generate_token!
    self.token = SecureRandom.hex
  end
end
