User.create!(
  email: 'admin@example.com', 
  name: 'admin',
  password: 'admin@example.com',
  role: 'admin')

alice = User.create!(
    email: 'alice@example.com', 
    name: 'alice',
    password: 'alice@example.com')
    
bob = User.create!(
    email: 'bobby@example.com', 
    name: 'bobby',
    password: 'bobby@example.com')
    
talk = Talk.create!(title: 'Alice with Bobby')

talk.users << [alice, bob]

50.times do |i|
  talk.messages << Message.create!(
    talk: talk,
    user: [alice, bob].sample, 
    body: Faker::Lorem.sentence)
end

50.times do |i|
  User.create(
    email: "user#{i}@example.com", 
    name: Faker::Name.name,
    password: 'password')
end

