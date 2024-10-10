module ToastHelper
  def render_flash(type:, message:)
    # app/views/shared/toasts/error.html.erb
    render partial: "shared/toasts/#{type.to_s}", locals: {message: message}
  end
end
