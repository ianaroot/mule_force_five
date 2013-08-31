deck = Deck.create(name: "dutch_vocab")

CSV.foreach("./public/nederlands.csv") do |row|
  term       = row.first
  definition = row.last
  Card.create(term: term, definition: definition, deck_id: 1)
end

