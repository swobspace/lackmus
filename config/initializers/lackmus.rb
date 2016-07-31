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

  def self.mail_from
    if CONFIG['mail_from'].present?
      @@mail_from ||= CONFIG['mail_from']
    else
      @@mail_from ||= 'lackmus@localhost.local'
    end
  end

  def self.mail_from=(from)
    @@mail_from = from
  end
end

