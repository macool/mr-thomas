require 'uri'

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
          referrer: referrer,
          parameters: permitted_params,
          request_ip: request.remote_ip,
          g_recaptcha_response: params["g-recaptcha-response"]
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
      rescue Mongoid::Errors::DocumentNotFound
        render(
          :error,
          status: :unprocessable_entity
        )
      end

      def host
        URI.parse(referrer).host
      end
      
      def referrer
        request.referrer.presence || request.headers["HTTP_ORIGIN"]
      end
    end
  end
end
