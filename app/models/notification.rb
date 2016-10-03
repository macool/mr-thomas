require 'g_recaptcha'

class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  REQUIRED_PARAMS = [
    :email,
    :nombre,
    :mensaje
  ]

  attr_accessor :g_recaptcha_response

  field :referrer
  field :request_ip
  field :parameters, type: Hash

  belongs_to :subscriber

  validate :validate_all_params!
  validate :verify_recaptcha!

  after_create :notify!

  private

  def notify!
    NotificationMailer.notify_remitent(
      id.to_s
    ).deliver_later
  end

  def validate_all_params!
    parameters.slice(*REQUIRED_PARAMS).each do |key, value|
      errors.add(
        :parameters,
        "#{key} no puede estar en blanco"
      ) if value.blank?
    end
  end

  def verify_recaptcha!
    # only if subscriber account requires it
    if subscriber.require_recaptcha?
      if !GRecaptcha.verify(self)
        errors.add(
          :g_recaptcha_response,
          "Invalid recaptcha"
        )
      end
    end
  end
end
