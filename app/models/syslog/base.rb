class Syslog::Base < ActiveRecord::Base
  self.abstract_class = true
  self.pluralize_table_names = true

  # -- validations and callbacks
  # -- attributes

  # -- establish connection
  if ActiveRecord::Base.configurations.keys.include?("syslog")
    establish_connection :syslog
  else
    raise "ERROR: need a configured otrs database!"
  end
end
