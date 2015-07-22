require 'rails_helper'

RSpec.describe Drink, type: :model do
  it { is_expected.to belong_to(:menu) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_one(:image).dependent(:destroy) }
end
