class GRecaptcha
  RECAPTCHA_HOST = 'https://www.google.com/recaptcha/api/siteverify'

  class << self
    def verify(notification)
      new(notification).verify
    end
  end

  def initialize(notification)
    @notification = notification
  end

  def verify
    response = HTTParty.post(RECAPTCHA_HOST, body: body)
    response.parsed_response["success"]
  end

  def body
    {
      remoteip: @notification.request_ip,
      response: @notification.g_recaptcha_response,
      secret:   Rails.application.secrets.recaptcha_secret
    }
  end
end