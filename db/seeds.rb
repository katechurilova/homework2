[
  ["Star Wars", "PG", "1977-05-02 00:00:00 UTC","This story is about Star Wars"],
  ["Aladdin", "G", "1992-11-25 00:00:00 UTC","This story is about Aladdin"],
  ["The Terminator", "R", "1984-10-26 00:00:00 UTC","This story is about The Terminator"],
  ["When Harry Met Sally", "R", "1989-07-21 00:00:00 UTC","This story is about When Harry Met Sally"],
  ["The Help", "PG-13", "2011-08-10 00:00:00 UTC","This story is about Help"],
  ["Chocolat", "PG-13", "2001-01-05 00:00:00 UTC","This story is about Chocolat"],
  ["Amelie", "R", "2001-04-25 00:00:00 UTC","This story is about Amelie"],
  ["2001: A Space Odyssey", "G", "1968-04-06 00:00:00 UTC","This story is about 2001: A Space Odyssey"],
  ["The Incredibles", "PG", "2004-11-05 00:00:00 UTC","This story is about The Incredibles"],
  ["Raiders of the Lost Ark", "PG", "1981-06-12 00:00:00", "This story is about Raiders of the Lost Ark"],
  ["Chicken Run", "G", "2000-06-21 00:00:00", "This story is about Chicken Run"]
].each do |(title, rating, date, description)|
  Movie.create! title: title, rating: rating, release_date: DateTime.parse(date), description: description
end

