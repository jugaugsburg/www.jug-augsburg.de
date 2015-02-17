module Jekyll

  class EventPage < Page
    def initialize(site, base, dir, event)
      @site = site
      @base = base
      @dir = dir
      @name = event["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'event.html')
      self.data['event'] = event
      self.data['title'] = event["name"] 
    end
  end

  class EventIndexPage < Page
    def initialize(site, base, dir, events)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      events.each do |event|
        event["slug"] = event["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')  
      end

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'event-index.html')
      self.data['events'] = events
      self.data['title'] = "Veranstaltungen"
    end
  end

  class EventPageGenerator < Generator
    safe true

    def generate(site)
        dir = 'events'
        site.data["events"].each do |event|
          site.pages << EventPage.new(site, site.source, "veranstaltungen", event)
        end

        site.pages << EventIndexPage.new(site, site.source, "veranstaltungen", site.data["events"])
    end
  end
end