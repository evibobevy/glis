# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  # Event
  Event.create(title: 'Diwali', event_date:Time.now, image: "http://www.sonicfoundry.com/wp-content/uploads/2015/06/UL2013_Events4-616x411.jpg")
  Event.create(title: 'Test Event1', event_date:Time.now - 1.days, image: "http://www.sonicfoundry.com/wp-content/uploads/2015/06/UL2013_Events4-616x411.jpg")
  Event.create(title: 'Test Event3', event_date:Time.now - 4.days, image: "https://pbs.twimg.com/media/CeKWHd2XEAAj9dT.jpg")
  Event.create(title: 'Test Event4', event_date:Time.now - 8.days, image: "http://www.freelargeimages.com/wp-content/uploads/2015/11/Christmas_16.jpg")
  Event.create(title: 'Test Event5', event_date:Time.now - 10.days, image: "http://c.tadst.com/gfx/600x400/christmas.jpg?1")
  Event.create(title: 'Test Event6', event_date:Time.now - 5.days, image: "http://onlineclock.net/bg/xmas/merry-xmas.jpg")
  # User
  User.create(email: 'TestVolunteer1@gmail.com',password: '12345678', password_confirmation: '12345678', image:"http://cdni.wired.co.uk/1240x826/g_j/GettyImages-474978498.jpg", first_name:"Testfname1", last_name:"Testlname1")
  User.create(email: 'testvolunteer2@gmail.com',password: '12345678', password_confirmation: '12345678',image:"https://cdn.meme.am/instances/54237896.jpg", first_name:"Testfname2", last_name:"Testlname2")
  User.create(email: 'testvolunteer3@gmail.com',password: '12345678', password_confirmation: '12345678',image:"http://img.deusm.com/informationweek/2015/08/1321706/SundarPichai129-%282%29.jpg", first_name:"Testfname3", last_name:"Testlname3")
  User.create(email: 'testvolunteer6@gmail.com',password: '12345678', password_confirmation: '12345678', image:"http://tcbmag.com/getattachment/ffa0ca0e-5d43-4bfc-a771-8c9fc85b2501", first_name:"Testfname4", last_name:"Testlname4")
  User.create(email: 'testvolunteer7@gmail.com',password: '12345678', password_confirmation: '12345678', image:"http://specials-images.forbesimg.com/imageserve/459305150/640x0.jpg?fit=scale", first_name:"Testfname5", last_name:"Testlname5")

  # Post.create(name:'Testing post..!', user_id: 1 ,event_id: 1, created_at: Time.now - 5.days)




