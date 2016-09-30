class KeepaliveController < ApplicationController
  def show
    asset = Rails.application.assets["mr-thomas.png"]
    send_file asset.filename, disposition: "inline"
  end
end
