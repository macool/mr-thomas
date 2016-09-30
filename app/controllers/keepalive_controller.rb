class KeepaliveController < ApplicationController
  def show
    filename = Rails.root.join "public", "images", "mr-thomas.png"
    send_file filename, disposition: "inline"
  end
end
