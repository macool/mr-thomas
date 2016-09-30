class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  REQUIRED_PARAMS = [
    :email,
    :nombre,
    :mensaje
  ]

  field :referrer
  field :request_ip
  field :parameters, type: Hash

  belongs_to :subscriber

  validate :validate_all_params!

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
end
