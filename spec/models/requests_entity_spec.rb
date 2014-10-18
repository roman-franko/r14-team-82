require 'rails_helper'

RSpec.describe RequestsEntity, :type => :model do
  it { expect(create(:requests_entity)).to be_valid }
end
