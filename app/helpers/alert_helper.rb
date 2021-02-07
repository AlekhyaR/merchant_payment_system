module AlertHelper
  def alert_class_by_type(alert_type)
    case alert_type.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-danger'
    end
  end

  def with_each_alert_message(alert)
    alert.each do |k, v|
      alert_class = flash_class(k)
      case v
      when Hash
        v.each_value do |vv|
          yield(alert_class, vv)
        end
      when Array
        v.each { |vv| yield(alert_class, vv) }
      else
        yield(alert_class, v)
      end
    end
  end
end