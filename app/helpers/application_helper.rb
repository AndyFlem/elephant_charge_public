module ApplicationHelper
end

def format_position(pos)
  ret='<b>1<sup>st</sup></b>'.html_safe if pos==1
  ret='<b>2<sup>nd</sup></b>'.html_safe if pos==2
  ret='<b>3<sup>rd</sup></b>'.html_safe if pos==3
  ret=(pos.to_s + '<sup>th</sup>').html_safe if pos>3
  ret
end

def current_controller
  Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:controller]
end