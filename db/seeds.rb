# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


team1 = Team.create(name: 'Liverpool')
team2 = Team.create(name: 'Barcelona')
team3 = Team.create(name: 'Real Madrid')

member1 = Member.create(first_name: 'Cristiano', last_name:'Ronaldo', city:'San Francisco', state:'CA', country:"USA", team_id:team1.id)
member2 = Member.create(first_name: 'Mike', last_name:'Sharapova', city:'San Francisco', state:'CA', country:"USA", team_id:team1.id)
member3 = Member.create(first_name: 'Joe', last_name:'Messi', city:'San Francisco', state:'CA', country:"USA", team_id:team1.id)
member4 = Member.create(first_name: 'Henry', last_name:'White', city:'San Francisco', state:'CA', country:"USA", team_id:team2.id)
member5 = Member.create(first_name: 'Maria', last_name:'Sharapova', city:'San Francisco', state:'CA', country:"USA", team_id:team2.id)