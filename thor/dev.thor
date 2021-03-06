module Dev
  class Env < Thor::Group
    include Thor::Actions

    argument :project_root, :type => :string, :default => File.expand_path( File.dirname( __FILE__ ) )
    class_option :vagrant_mount_file, :type => :string, :aliases => [ '-V' ], :default => 'config.json'
    class_option :output_file, :type => :string, :aliases => [ '-o' ], :default => 'Vagrantfile'
    class_option :shell_script_output_dir, :type => :string, :aliases => [ '-s' ], :default => './bin'
    def self.source_root
      File.join( File.dirname(__FILE__), '..','lib', 'templates' )
    end

    def create_install_vagrant_plugins_script
      config           = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template_name    = 'install_vagrant_plugins.sh.erb'
      output_file_name = File.join( options[:shell_script_output_dir],  'install_vagrant_plugins.sh' )
      if config.has_key?('vagrant_plugins')
        template(
          template_name,
          output_file_name,
          :vagrant_plugins => config['vagrant_plugins']
        )
      end
    end

    def generate_install_brew_script
      config          = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template_name   = 'install_brews.sh.erb'
      output_filename = File.join( options[:shell_script_output_dir], 'install_brews.sh' )
      if config.has_key?('brews')
        template(
          template_name,
          output_filename,
          :brews => config['brews']
        )
      end
    end

    def generate_install_brewcasks_script
      config          = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template_name   = 'install_casks.sh.erb'
      output_filename = File.join( options[:shell_script_output_dir], 'install_casks.sh' )
      if config.has_key?('brewcasks')
        template(
          template_name,
          output_filename,
          :brewcasks => config['brewcasks']
        )
      end
    end

    def generate_install_gems
      config          = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template_name   = 'install_gems.sh.erb'
      output_filename = File.join( options[:shell_script_output_dir], 'install_gems.sh' )
      if config.has_key?('gems')
        template(
          template_name,
          output_filename,
          :gems => config['gems']
        )
      end
    end

    def generate_install_npm
      config          = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template_name   = 'install_npms.sh.erb'
      output_filename = File.join( options[:shell_script_output_dir], 'install_npms.sh' )
      if config.has_key('npms')
        template(
          template_name,
          output_filename,
          :npms => config['npms']
        )
      end
    end

    # def create_vagrant_file
    #   config = load_json_config_file( project_root, options[:vagrant_mount_file] )
    #   template(
    #     'Vagrantfile.erb',
    #     options[:output_file],
    #     {
    #       :mounts                => config['mounts'],
    #       :vagrant_plugins       => config['vagrant_plugins'],
    #       :vagrant_port_forwards => config['vagrant_port_forwards']
    #     }
    #   )
    # end

    private

    def load_json_config_file( path, json_file )
      require 'json'
      current_path = File.expand_path( File.dirname( path ) )

      json_file_path = File.join( current_path, json_file )
      # say "json file is #{json_file_path}", :yellow
      JSON.parse( IO.read( json_file_path ) )
    end
  end
end
