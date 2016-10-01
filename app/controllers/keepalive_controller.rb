class KeepaliveController < ApplicationController
  before_action :log_keepalive!

  def show
    filename = Rails.root.join "public", "images", "mr-thomas.png"
    send_file filename, disposition: "inline"
  end

  private

  def log_keepalive!
    keep_alive = KeepAlive.new(
      referrer: request.referrer,
      request_ip: request.remote_ip
    )
    keep_alive.save unless keep_alive.localhost?
  end
end
