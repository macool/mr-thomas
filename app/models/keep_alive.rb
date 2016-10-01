require 'uri'

class KeepAlive
  include Mongoid::Document
  include Mongoid::Timestamps

  field :referrer
  field :request_ip

  validate :validate_not_blank
  after_create :update_subscriber_counter_cache!

  private

  def validate_not_blank
    errors.add(
      :base,
      "can't be blank'"
    ) if referrer.blank? && request_ip.blank?
  end

  def update_subscriber_counter_cache!
    return if referrer.blank?
    host = URI.parse(referrer).host
    if Subscriber.where(host: host).exists?
      Subscriber.find_by(host: host).inc(
        keepalives_count: 1
      )
    end
  end
end
