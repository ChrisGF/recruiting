ADDRESSES=[
  { address1: "Main Street",
    city: "Atlanta",
    state: "GA",
    zipcode: 11123
  }, {
    address1: "Fayetteville Street",
    city: "Raleigh",
    state: "GA",
    zipcode: 23445
  }, {
    address1: "Bull Durham Drive",
    city: "Durham",
    state: "GA",
    zipcode: 54332
  }, {
    address1: "Apple Grove Dr",
    city: "Chappel Hill",
    state: "GA",
    zipcode: 12343
  }, {
    address1: "Landsdown Street",
    city: "Boston",
    state: "GA",
    zipcode: 42412
  }, {
    address1: "Orchard Park Rd",
    city: "Buffalo",
    state: "GA",
    zipcode: 12321
  }, {
    address1: "Spring Hill Lane",
    city: "Syracuse",
    state: "GA",
    zipcode: 76453
  }
]

after :users do
  CLOSE_TIMELINE = ['Jun 2014', 'Jul 2014', 'Aug 2014']
  DESCRIPTIONS = ["This beautiful 3 bedroom, 2 bath, one-story 2000 square-foot house is located on one and a half acres down a quiet country road with a surrounding front and back yard including a back deck perfect for BBQs and a nice garden in front.",
    "This gorgeous and cozy 4 bedroom 3-and-a-half bath 3000 square foot home is located on a two acre lot on a quiet suburban street, close to two elementary schools. The home is the perfect size for a family with children.",
    "The amenities include a beautiful brick fireplace in the living room, as well as a large picture window overlooking the valley. The kitchen is complete with new granite countertops and elegant oak cabinets, as well as a brand new stove and oven.",
    "This beautiful home also comes with an attached two-car garage, near the kitchen, as well as a storage shed for additional space on the side of the house.",
    "As you walk up to this gorgeous 4 bedroom 3-and-a-half bath, 3500 square foot home, you find a beautiful porch that wraps around the right side of the house complete with a cozy swing in front. ",
    "The property also comes with a large back deck as well as a fenced yard in back and a blocked off area for gardening. The back of the home overlooks the bay and is perfect for star-gazing or watching sunsets.",
    "This cozy home is complete with a wood fireplace in the living room with a 8' X 6' window facing the green hillside and acres of open land, as well as a woodstove in the family dining room.",
    "This home sits on a beautiful lot of over ¼ acre, with majestic mature trees, a vegetable/flower garden on one side in the back and a picnic table on the other side, shaded by a cascading evergreen tree.",
    "There is a two-year old Pacific Energy woodburning stove in the spacious and light living room, an effective contrast to the gleaming wood floors surrounding it. This stove will heat the entire upper level.",
    "There is plenty of storage on the upper as well as the lower level. Included also are the washer and dryer, and water softener. The high-efficiency furnace, central air, gas hot water heater (quick recovery), space guard air cleaner.",
    "All of the interior of this house is like new, with beautifully finished woodwork and newly refinished hardwood floors. There is carpeting in the bedrooms and hallway, laid over the refinished hardwood floors."
  ]


  (0..10).each { |index|
    address = ADDRESSES.sample
    name = "#{rand(6000)} #{address[:address1]}"

    deal = Deal.where(name: name).first_or_initialize

    if deal.new_record?
      user = User.all.order("RANDOM()").first
      deal.address = Address.new(address)
      deal.short_description = DESCRIPTIONS.sample
      deal.amount_to_raise = rand(5..30) * 10000
      deal.close_timeline = CLOSE_TIMELINE.sample
      deal.followers_count = 0
      deal.user = user
      deal.save!
      puts "Deal Saved: #{deal.name} -> #{user.email}"
    end
  }
end