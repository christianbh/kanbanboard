xml.instruct! :xml, :version=>"1.0",
:encoding=>"UTF-8"
xml.data do
  for event in @events do
    xml.event(event.details, 'start' => event.start.strftime("%b %d %Y %H:%M:%S %Z"), 'end' => event.end.strftime("%b %d %Y %H:%M:%S %Z"), 'isDuration' => event.span, 'title' => event.title)  
  end
end