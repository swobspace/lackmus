class LogSyslogsysevent
  attr_reader :sysevent
  def initialize(sysevent)
    @sysevent = sysevent
  end

  def self.log(sysevent)
    self.new(sysevent).log
  end

  def log
    Rails.logger.debug(logentry)
  end

private
  def logentry
    "#{sysevent.fromhost}: #{sysevent.devicereportedtime} / " +
    "message size: #{sysevent.message.size}"
  end
end
