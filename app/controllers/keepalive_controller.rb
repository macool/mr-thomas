class KeepaliveController < ApplicationController
  before_action :process_keepalive!

  def show
    filename = Rails.root.join "public", "images", "mr-thomas.png"
    send_file filename, disposition: "inline"
  end

  private

  def process_keepalive!
    @keep_alive = KeepAlive.new(
      referrer: request.referrer,
      request_ip: request.remote_ip
    )
    persist_keepalive_if_needed!
    set_client!
  end

  def persist_keepalive_if_needed!
    if !@keep_alive.localhost?
      @keep_alive.save if new_client?
    end
  end

  ##
  # be sure to call #new_client? ONLY
  # before #set_client!
  def new_client?
    return false if admin_in_session?
    in_session = session.fetch(host_uid, nil)
    in_session.blank? || (
      Time.parse(in_session) < 1.hour.ago
    )
  end

  ##
  # do not log admin's requests
  def admin_in_session?
    session.fetch("warden.user.admin.key", nil).present?
  end

  def set_client!
    session[host_uid] = Time.now.to_s
  end

  ##
  # unique for each host
  # used in session
  def host_uid
    "host_#{@keep_alive.host}"
  end
end
