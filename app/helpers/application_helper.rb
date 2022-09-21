module ApplicationHelper
  def rendering_landing_page
    return if user_signed_in?

    (params[:controller] == 'pages' && params[:action] == 'home') # ||
    # (params[:controller].match? /(twilio|devise)/)
  end
end
