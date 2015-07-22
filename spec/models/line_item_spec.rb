require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:drink) }
end
