class Admin
  class SubscribersController < BaseController
    before_action :find_subscriber,
                  only: [:show, :edit, :update, :destroy, :regenerate_token]
    def index
      @subscribers = Subscriber.all
    end

    def new
      @subscriber = Subscriber.new
    end

    def show
    end

    def edit
    end

    def create
      @subscriber = Subscriber.new(subscriber_params)
      if @subscriber.save
        redirect_to action: :show,
                    id: @subscriber.id
      else
        render :new
      end
    end

    def update
      if @subscriber.update(subscriber_params)
        redirect_to action: :show,
                    id: @subscriber.id
      else
        render :edit
      end
    end

    def regenerate_token
      @subscriber.regenerate_token!
      redirect_to action: :show,
                  id: @subscriber.id
    end

    def destroy
      @subscriber.destroy
      redirect_to action: :index
    end

    private

    def find_subscriber
      @subscriber = Subscriber.find params[:id]
    end

    def subscriber_params
      params.require(:subscriber)
            .permit(
              :name,
              :host,
              :recipient
            )
    end
  end
end