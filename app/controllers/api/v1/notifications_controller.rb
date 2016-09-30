module Api
  module V1
    class NotificationsController < ApplicationController
      skip_before_filter :verify_authenticity_token,
                         only: :create
      before_filter :find_subscriber,
                    only: :create 
      before_filter :new_notification,
                    only: :create
      before_filter :find_notification,
                    only: :show

      def show
        if @notification.present?
          render :success
        else
          render :error
        end
      end

      def create
        if @notification.save
          session[:notification_id] = @notification.id
          render :success, status: :created
        else
          render :error, status: :unprocessable_entity
        end
      end

      private

      def find_notification
        @notification = Notification.find(
          session[:notification_id]
        ) if session[:notification_id].present?
      end

      def new_notification
        session[:notification_id] = nil # clear cache
        @notification = @subscriber.notifications.new(
          referrer: request.referrer,
          parameters: permitted_params
        )
      end

      def permitted_params
        params.permit(
          *Notification::REQUIRED_PARAMS
        )
      end

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
  end
end
