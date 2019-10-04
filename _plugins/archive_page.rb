module Jekyll

  class ArchivePage < Page
    def initialize(site, base, dir, archive)
      @site = site
      @base = base
      @dir = dir
      @name = archive["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive.html')
      self.data['archive'] = archive
      self.data['title'] = archive["name"] 
    end
  end

  class ArchiveIndexPage < Page
    def initialize(site, base, dir, archives)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      archives.each do |archive|
        archive["slug"] = archive["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')  
      end

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive-index.html')
      self.data['archives'] = archives
      self.data['title'] = "Archiv"
    end
  end

  class ArchivePageGenerator < Generator
    safe true

    def generate(site)
        dir = 'archives'
        site.data["archives"].each do |archive|
          site.pages << ArchivePage.new(site, site.source, "archives", archive)
        end

        site.pages << ArchiveIndexPage.new(site, site.source, "archives", site.data["archives"])
    end
  end
end