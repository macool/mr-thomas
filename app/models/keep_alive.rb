class KeepAlive
  include Mongoid::Document
  include Mongoid::Timestamps

  field :referrer
  field :request_ip

  validate :validate_not_blank

  private

  def validate_not_blank
    errors.add(
      :base,
      "can't be blank'"
    ) if referrer.blank? && request_ip.blank?
  end
end
