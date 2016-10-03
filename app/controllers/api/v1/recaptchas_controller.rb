module Api
  module V1
    class RecaptchasController < ApplicationController
      before_action :force_js
      skip_before_filter :verify_authenticity_token,
                         only: :show

      def show
        @recaptcha_key = Rails.application.secrets.recaptcha_key
      end

      private

      def force_js
        request.format = "js"
      end
    end
  end
end