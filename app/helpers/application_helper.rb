module ApplicationHelper
  def rendering_landing_page
    return if user_signed_in?

    (params[:controller] == 'pages' && params[:action] == 'home') ||
    params[:controller].match?(/^(twilio|devise)/)
  end

  def right_class_to_option_radio_button(answer)
    if answer.correct.nil?
      ''
    elsif answer.correct
      'right'
    else
      'wrong'
    end
  end
end
