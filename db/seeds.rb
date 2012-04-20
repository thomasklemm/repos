# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

repos = Repo.create([{owner: "zurb", name: "foundation"}, {owner: "rails", name:"rails"}, {owner: "twitter", name:"bootstrap"}, {owner: "jashkenas", name:"coffee-script"}, {owner: "visionmedia", name: "express"}, {owner: "thomasklemm", name: "foundation"}])
