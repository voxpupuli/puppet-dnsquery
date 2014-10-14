#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe 'the dns_srv function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('dns_srv')).to eq('function_dns_srv')
  end

  it 'should raise a ArgumentError if there is less than 1 arguments' do
    expect { scope.function_dns_srv([]) }.to raise_error(ArgumentError)
  end

  it 'should raise a ArgumentError if there is more than 2 arguments' do
    expect { scope.function_dns_srv(['foo', 'bar', 'baz']) }.to raise_error(ArgumentError)
  end

  it 'should return a list of SRV records when doing a lookup' do
    results = scope.function_dns_srv(['_spotify-client._tcp.spotify.com'])
    expect(results).to be_a Array
    expect(results).to all( be_a Array )
    results.each do |res|
      expect(res.length).to eq(4)
      expect(res[0]).to be_a Integer # priority
      expect(res[1]).to be_a Integer # weight
      expect(res[2]).to be_a Integer # port
      expect(res[3]).to be_a String  # target
    end
  end

  it 'should return a list of SRV priorities when doing a lookup specifying that' do
    results = scope.function_dns_srv(['_spotify-client._tcp.spotify.com', 'priority'])
    expect(results).to be_a Array
    expect(results).to all( be_a Integer )
  end

  it 'should return a list of SRV weigths when doing a lookup specifying that' do
    results = scope.function_dns_srv(['_spotify-client._tcp.spotify.com', 'weight'])
    expect(results).to be_a Array
    expect(results).to all( be_a Integer )
  end

  it 'should return a list of SRV ports when doing a lookup specifying that' do
    results = scope.function_dns_srv(['_spotify-client._tcp.spotify.com', 'port'])
    expect(results).to be_a Array
    expect(results).to all( be_a Integer )
  end

  it 'should return a list of SRV targets when doing a lookup specifying that' do
    results = scope.function_dns_srv(['_spotify-client._tcp.spotify.com', 'target'])
    expect(results).to be_a Array
    expect(results).to all( be_a String )
  end

  it 'should raise a ArgumentError for invalid values to second argument' do
    expect { scope.function_dns_srv(['_spotify-client._tcp.spotify.com', 'foo']) }.to raise_error(ArgumentError)
  end
end
