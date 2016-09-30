class KeepaliveController < ApplicationController
  def show
    filename = ActionController::Base.helpers.asset_path "mr-thomas.png"
    send_file filename, disposition: "inline"
  end
end
