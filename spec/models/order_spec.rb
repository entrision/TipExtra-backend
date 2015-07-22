require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:line_items).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to accept_nested_attributes_for(:line_items) }

  it { is_expected.to validate_presence_of(:user) }
end
