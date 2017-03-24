require "spec_helper"

module Swoon
  describe API do
    let(:api_key) { 'fake-api-key' }
    let(:base_url) { 'https://api.sendwithus.com/api/v1' }
    let(:api_url) { base_url + resource_path }
    let(:api) { API.new(api_key: api_key) }
    let(:api_request) do
      {
        params: params,
        x_swu_api_key: api_key,
        x_swu_api_client: 'swoon 0.1.0',
        accept: 'application/json',
        content_type: 'application/json'
      }
    end

    describe '#tempates' do
      let(:params) { nil }

      describe '#retrieve' do
        before do
          allow(RestClient)
            .to receive(:get)
            .with(
              api_url,
              api_request
            )
        end
        context 'without arguments' do
          let(:resource_path) { '/templates' }
          it 'requests GET /templates' do
            expect(RestClient)
              .to receive(:get)
              .with(
                api_url,
                params: params,
                x_swu_api_key: api_key,
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
            api.templates.retrieve
          end
        end
        context 'with id' do
          let(:resource_path) { '/templates/some-id' }
          it 'requests GET /templates/some-id' do
            expect(RestClient)
              .to receive(:get)
              .with(
                api_url,
                api_request
              )
            api.templates('some-id').retrieve
          end
        end
      end
    end

    describe '#send' do
      context 'with valid params' do

      end

    end

    describe '#logs' do

    end

    describe '#batch' do

    end

    describe '#snippets' do

    end

    describe '#render' do

    end

    describe '#esp_accounts' do

    end

    describe '#customers' do
      describe '#conversions' do

      end
    end

    describe '#drip_campaigns' do

    end

    describe '#i18n' do

    end

    describe '#batch' do

    end
  end
end
