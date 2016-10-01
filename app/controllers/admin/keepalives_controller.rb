class Admin
  class KeepalivesController < BaseController
    def show
      @keepalives = KeepAlive.order(created_at: :desc).limit(25)
    end
  end
end
