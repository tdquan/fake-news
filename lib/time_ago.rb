module TimeAgo
	def self.time_ago(timestamp)
    delta = Time.now - timestamp
    case delta.to_i
    when 0..30
    	return "just now"
    when 31..119
    	return "about a minute ago"
    when 120..3599
    	return "#{(delta / 60).round} minutes ago"
    when 3600..86399
    	return "#{(delta / 3600).round} hours ago"
    when 86400..604799
    	return "#{(delta / 86400).round} days ago"
    when 604800..2591999
    	return "#{(delta / 604800).round} weeks ago"
    when 2592000..31536000
    	return "#{(delta / 31536000).round} months ago"
    else
    	return "Long time ago"
    end
	end
end
