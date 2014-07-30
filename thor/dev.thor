module Devenv
  class Init < Thor::Group
    include Thor::Actions

    def self.source_root
      File.join( File.dirname(__FILE__), '..', 'templates' )
    end
  end
end
