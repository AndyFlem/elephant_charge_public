module ApplicationHelper
end

def small_caps
  ("<span style='font-variant: small-caps'>" + yield + "</span>").html_safe
end
def bold
  ("<b>" + yield + "</b>").html_safe
end

def entry_path(entry)
  '/' + entry.charge.ref + '/' + entry.team.ref
end
def charge_path(charge)
  '/' + charge.ref
end
def charge_entries_path(charge)
  '/' + charge.ref + '/teams'
end

def team_path(team)
  '/' + team.ref
end
def beneficiary_path(beneficiary)
  '/beneficiary/' + beneficiary.short_name
end

def format_meters(m)
  if m>1000
    number_with_precision(m/1000.0,precision:1,delimeter:',') + "km"
  else
    number_with_precision(m,precision:0,delimeter:',') + "m"
  end
end

def format_seconds(secs)
  if secs>120
    format_minutes((secs/60.0).round)
  else
    secs.to_s + 's'
  end
end
def format_minutes(mins)
  if mins>60
    format_hours((mins/60.0).to_i) + ' ' + format_minutes(mins % 60)
  else
    mins.to_s+' minute' +(mins>1 ? 's':'')
  end
end
def format_hours(hrs)
  hrs.to_s + ' hour' + (hrs>1 ? 's':'')
end

def format_position(pos)
  ret=format_position2(pos)
  if pos<4
    ret='<b>' + ret + '</b>'
  end
  ret.html_safe
end

def format_position2(pos)
  ret='1<sup>st</sup>'.html_safe if pos==1
  ret='2<sup>nd</sup>'.html_safe if pos==2
  ret='3<sup>rd</sup>'.html_safe if pos==3
  ret=(pos.to_s + '<sup>th</sup>').html_safe if pos>3
  ret
end


def current_controller
  Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:controller]
end
def current_action
  Rails.application.routes.recognize_path(request.env['PATH_INFO'])[:action]
end