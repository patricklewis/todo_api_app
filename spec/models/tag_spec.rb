require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to validate_uniqueness_of :title }
end
