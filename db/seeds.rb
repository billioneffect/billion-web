# Required data on start up
# Not for development fake data!

FactoryGirl.create :user_role
FactoryGirl.create :admin_role

ProductFeature.where(name: 'sms-voting').first_or_create
