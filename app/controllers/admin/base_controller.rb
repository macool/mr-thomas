class Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin!

    layout 'admin'
  end
end