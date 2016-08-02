# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# # #
# # # Examples:
# # #
# # #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   # Event
# #   Event.create!(title: 'Diwali', start_time:Time.now, event_date:Time.now, end_date:Time.now + 1.days)
# #   # Event.create!(title: 'Test Event1', start_time:Time.now, event_date:Time.now - 1.days)
# #   # Event.create!(title: 'Test Event3', start_time:Time.now, event_date:Time.now - 4.days)
# #   # Event.create!(title: 'Test Event4', start_time:Time.now, event_date:Time.now - 8.days)
# #   # Event.create!(title: 'Test Event5', start_time:Time.now, event_date:Time.now - 10.days)
# #   # Event.create!(title: 'Test Event6', start_time:Time.now, event_date:Time.now - 5.days)
# #   # User
# #   User.create!(email: 'TestVolunteer1@gmail.com', confirm_email: 'TestVolunteer1@gmail.com', password: '12345678', password_confirmation: '12345678', first_name:"Testfname1", last_name:"Testlname1")
# #   # User.create!(email: 'testvolunteer2@gmail.com', confirm_email: 'testvolunteer2@gmail.com', password: '12345678', password_confirmation: '12345678', first_name:"Testfname2", last_name:"Testlname2")
# #   # User.create!(email: 'testvolunteer3@gmail.com', confirm_email: 'testvolunteer3@gmail.com', password: '12345678', password_confirmation: '12345678', first_name:"Testfname3", last_name:"Testlname3")
# #   # User.create!(email: 'testvolunteer6@gmail.com', confirm_email: 'testvolunteer6@gmail.com', password: '12345678', password_confirmation: '12345678', first_name:"Testfname4", last_name:"Testlname4")
# #   # User.create!(email: 'testvolunteer7@gmail.com', confirm_email: 'testvolunteer7@gmail.com', password: '12345678', password_confirmation: '12345678', first_name:"Testfname5", last_name:"Testlname5")
# #   ## Post
# #   Post.create!(name:'Shankle biltong short loin, rump t-bone salami drumstick chuck doner pastrami ham hock spare ribs frankfurter. Pancetta swine picanha filet mignon sirloin.
# #  Shankle biltong short loin, rump t-bone salami drumstick chuck doner.', user_id: 1 ,event_id: 1, created_at: Time.now - 5.days)
# #  ### Comment ##
# #  Comment.create(commenter:"Bacon ipsum dolor amet boudin bacon pancetta drumstick capicola brisket.", post_id: 1, created_at: Time.now - 5.days)
# #  Comment.create(commenter:"prosciutto sausage ball tip salami pork chop cupim shank swine. [...].", post_id: 1, created_at: Time.now - 4.days)
# #
# #
# #
#
# post = Post.create!(name:'Shankle biltong short loin, rump t-bone salami drumstick chuck doner pastrami ham hock spare ribs frankfurter. Pancetta swine picanha filet mignon sirloin.
#  Shankle biltong short loin, rump t-bone salami drumstick chuck doner.', user_id: 23 ,foundation_id:1 , created_at: Time.now - 5.days)
# ### Comment ##
# Comment.create(commenter:"Bacon ipsum dolor amet boudin bacon pancetta drumstick capicola brisket.", post_id: post.id, created_at: Time.now - 5.days)
# Comment.create(commenter:"prosciutto sausage ball tip salami pork chop cupim shank swine. [...].", post_id: post.id, created_at: Time.now - 4.days)
#
