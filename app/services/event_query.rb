class EventQuery
  attr_reader :dirty, :filter, :query

  def initialize(options = {})
    options.symbolize_keys!
    @relation = options.fetch(:relation) { Event.all }
    @filter   = options.fetch(:filter).symbolize_keys
    @query   ||= build_query
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

  def build_query
    hash  = {}
    query = relation
    filter.each_pair do |key,value|
      # list of values? ensure Array
      values = Array(value.gsub(/[;,] +/, ";").split(%r{[,; |]+}))

      # ip address
      if [:src_ip, :dst_ip].include?(key)
        search_string = []
        values.each do |val|
          search_string << "events.#{key} <<= \'#{val}\'"
        end
        query = query.where(search_string.join(' or '))
      # wildcard
      elsif values.grep(/\*/).any?
        search_string = []
        values.each do |val|
          search_string << "events.#{key} LIKE \'#{val.tr('*', '%')}\'"
        end
        query = query.where(search_string.join(' or '))
      # don't touch the rest
      else
        hash[key] = values
      end
    end
    query.where(hash)
  end

end
