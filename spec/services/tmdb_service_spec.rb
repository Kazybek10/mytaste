require "rails_helper"

RSpec.describe TmdbService do
  describe ".search" do
    it "returns empty array when API is unavailable" do
      allow(Net::HTTP).to receive(:new).and_raise(SocketError)
      expect(TmdbService.search("inception")).to eq([])
    end

    it "returns empty array for blank query" do
      stub = instance_double(Net::HTTP)
      allow(Net::HTTP).to receive(:new).and_return(stub)
      allow(stub).to receive(:use_ssl=)
      allow(stub).to receive(:request).and_return(
        double(body: { "results" => [] }.to_json)
      )
      expect(TmdbService.search("")).to eq([])
    end
  end

  describe ".find" do
    it "returns nil when API is unavailable" do
      allow(Net::HTTP).to receive(:new).and_raise(SocketError)
      expect(TmdbService.find("123")).to be_nil
    end
  end
end
