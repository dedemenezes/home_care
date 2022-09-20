module ApplicationHelper
  def rendering_landing_page
    params[:controller] == 'pages' && params[:action] == 'home'
  end
end
