module Lackmus
  CONFIGURATION_CONTROLLER = []
  CONFIG = YAML.load_file(File.join(Rails.root, 'config', 'lackmus.yml'))

  def self.proxy
    if CONFIG['proxy'].present?
      CONFIG['proxy']
    else
      nil
    end
  end
end

