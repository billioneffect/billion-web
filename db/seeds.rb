# Required data on start up
# Not for development fake data!

FactoryGirl.create :user_role
FactoryGirl.create :admin_role

ProductFeature::FEATURES.each do |feature|
  ProductFeature.where(name: feature.to_s).first_or_create
end

ProductFeature.where.not(name: ProductFeature::FEATURES).delete_all
