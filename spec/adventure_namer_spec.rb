# frozen_string_literal: true

RSpec.describe AdventureNamer do
  it 'has a version number' do
    expect(AdventureNamer.version).not_to be nil
    expect(AdventureNamer.version).to be_a String
  end
end
