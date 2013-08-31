deck = Deck.create(name: "states_capitals")

CSV.foreach("./public/States.csv") do |row|
  term       = row.first
  definition = row[2]
  Card.create(term: term, definition: definition, deck_id: 1)
end

