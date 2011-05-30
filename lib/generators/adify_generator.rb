module Adify
  class AdifyGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :partial_type, :type => :string, :default => "dfp"

    def self.banner
      "rails generate adify:#{generator_name} #{self.arguments.map{ |a| a.usage }.join(' ')} [options]"
    end
  
    def generate_partial
      template "_#{partial_type}.html.erb", "app/views/adify/_#{partial_type}.html.erb"
    end
  end
end