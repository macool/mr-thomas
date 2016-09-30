class NotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :find_subscriber

  def create
    puts params
    head :ok
  end

  private

  def find_subscriber
    @subscriber = Subscriber.find_by(
      host: host,
      token: params[:token]
    )
  end

  def host
    URI.parse(request.referrer).host
  end
end
