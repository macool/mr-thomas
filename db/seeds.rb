[
  {
    host: "localhost",
    name: "fedes-local",
    recipient: "a@macool.me"
  },
  {
    host: "fedes-dev.herokuapp.com",
    name: "fedes-dev",
    recipient: "a@macool.me"
  },
  {
    host: "fedes.ec",
    name: "fedes-production",
    recipient: "a@macool.me"
  }
].each do |attrs|
  if Subscriber.where(name: attrs[:name]).exists?
    subscriber = Subscriber.find_by name: attrs[:name]
    puts "#{attrs[:name]} already exists! #{subscriber.pretty_print}"
  else
    subscriber = Subscriber.create(attrs)
    puts "creating subscriber: #{subscriber.pretty_print}"
  end
end