RSpec.configure do |config|
  def create(resource)
    FactoryGirl.create(resource)
  end
end
