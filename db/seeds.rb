[
  {
    host: "localhost",
    name: "fedes-local",
    recipient: "a@macool.me"
  }
].each do |attrs|
  puts "creating subscriber #{attrs}"
  Subscriber.create!(attrs)
end