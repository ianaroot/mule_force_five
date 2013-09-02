state_capitals = Deck.create(name: "states_capitals")

CSV.foreach("./public/States.csv") do |row|
  term       = row.first
  definition = row[2]
  Card.create(term: term, definition: definition, deck_id: state_capitals.id)
end

celebrity_quotes = Deck.create(name: "celebrity_quotes")

CSV.foreach("./public/celebrity_quotes.csv") do |row|
  term       = row.first
  definition = row.last
  Card.create(term: term, definition: definition, deck_id: celebrity_quotes.id)
end
