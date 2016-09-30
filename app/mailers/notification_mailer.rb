class NotificationMailer < ApplicationMailer
  def notify_remitent(id)
    @notification = Notification.find(id)
    @subscriber = @notification.subscriber
    mail(
      to: @subscriber.recipient,
      subject: "Notificación de contacto de #{@subscriber.name}"
     )
  end
end
