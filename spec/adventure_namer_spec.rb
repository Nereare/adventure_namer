# frozen_string_literal: true

RSpec.describe AdventureNamer do
  it 'has a version number' do
    expect(AdventureNamer.version).not_to be nil
    expect(AdventureNamer.version).to be_a String
  end
end

RSpec.describe AdventureNamer::Generator do
  let(:example) do
    AdventureNamer::Generator.new "#{__dir__}/test.txt"
  end

  it 'generates names' do
    expect(example.generate).not_to be nil
    expect(example.generate).to be_a String
  end
end
