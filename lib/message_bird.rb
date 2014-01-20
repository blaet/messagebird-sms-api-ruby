files = [
  'message_bird/config'
]

files.each do |file|
  require File.join(File.dirname(__FILE__), file)
end

module MessageBird

end
