module ApplicationHelper
end

def format_position(pos)
  ret='1st' if pos==1
  ret='2nd' if pos==2
  ret='3rd' if pos==3
  ret=pos.to_s + 'th' if pos>3
  ret
end

def current_controller
  Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:controller]
end