require 'snapcard'

describe Snapcard do
  let(:snapcard) do
    Snapcard::Client.new api_key: "A0gQfloO731hkLG", secret_key: "A7zjaklHkODeFiO"
  end

  context '#generate_signature' do
    it 'generates correct signatures' do
      uri = URI.parse "https://api.snapcard.io/rates"
      uri.query = URI.encode_www_form timestamp: 1458687110894
      signature1 = snapcard.send :generate_signature, uri, {}
      expect(signature1).to eq "a5067c02d0859c754e411c81fc30e55c8271e83c773da6f64f5cf2be2ace7067"
      signature2 = snapcard.send :generate_signature, uri, {"testProperty" => "testValue"}
      expect(signature2).to eq "37aec98359bfe8e3bc93c8baae4d8d36b6e5b028c3ee7a8fa40d6c1c6feae97d"
    end
  end

  # should probably have more tests
end
