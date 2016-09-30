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

  def pretty_print
    %Q{
      name: #{name}
      host: #{host}
      recipient: #{recipient}
      token: #{token}
    }
  end

  def full_host
    "http://#{host}"
  end

  def regenerate_token!
    send :generate_token!
    save!
  end

  private

  def generate_token!
    self.token = SecureRandom.hex(32)
  end
end
