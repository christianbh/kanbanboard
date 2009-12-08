xml.instruct! :xml, :version=>"1.0",
:encoding=>"UTF-8"
xml.data do
  for event in @events do
    endtime = event.end
    if (not event.span)
      endtime = event.start
    end
    xml.event(event.details, 'start' => event.start.strftime("%b %d %Y"), 'end' => endtime.strftime("%b %d %Y"), 'isDuration' => event.span, 'title' => event.title)  
  end
end