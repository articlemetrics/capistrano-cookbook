actions :load, :copy
default_action :load

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :default => ENV['USER']
attribute :group, :kind_of => String, :default => ENV['GROUP']
