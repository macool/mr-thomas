[
  {
    host: "localhost",
    name: "fedes-local",
    recipient: "a@macool.me"
  }
].each do |attrs|
  subscriber = Subscriber.create(attrs)
  puts "creating subscriber: #{subscriber.pretty_print}"
end