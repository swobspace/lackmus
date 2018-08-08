class EventFilterQuery
  attr_reader :dirty

  def initialize(options = {})
    options.symbolize_keys!
    @filter   = options.fetch(:filter).symbolize_keys
    @relation = options.fetch(:relation) { Event.all }
    @query   ||= process_query
    # dirty = true: mark query as complex, meaning a simple compare 
    # between filter hash with event attributes hash is not possible
    @dirty    = false	
  end

  def all
    query
  end

  def find_each(&block)
    query.find_each(&block)
  end

  def include?(event)
    query.where(id: event.id).limit(1).any?
  end

private
  attr_reader :query, :filter, :relation

  def process_query
    hash = {}
    q    = relation
    filter.each_pair do |key,value|
      # list of values
      if value =~ /[,;|]/
        hash[key] = value.gsub(/[;,] +/, ";").split(%r{[,;|]+})
        dirty = true
      # ip address
      elsif [:src_ip, :dst_ip].include?(key)
        q = q.where("#{key} <<= :ip", ip: value)
        dirty = true
      # wildcard
      elsif value.include?('*')
        q = q.where("#{key} LIKE :value", value: value.tr('*', '%'))
      # don't touch the rest
      else
        hash[key] = value
      end
    end
    q.where(hash)
  end

end
