require 'rails_helper'

RSpec.describe Image, type: :model do
  it { is_expected.to belong_to(:drink) }
end
