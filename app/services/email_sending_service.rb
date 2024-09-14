# frozen_string_literal: true

class EmailSendingService
  attr_reader :notification, :notification_type

  def initialize(notification)
    @notification = notification
    @notification_type = @notification.notification_type
  end

  def generate
    return unless mailer

    mailer.send(mailer_method, notification).deliver_later
  end

  private

  def mailer
    @mailer ||= if UserMailer.respond_to? mailer_method
                  UserMailer
                end
  end

  def mailer_method
    @mailer_method ||= "#{notification_type}_email"
  end
end
