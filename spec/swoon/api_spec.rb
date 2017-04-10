require 'spec_helper'

module Swoon
  describe API do
    let(:api_key) { 'fake-api-key' }
    let(:base_url) { 'https://api.sendwithus.com/api/v1' }
    let(:api_url) { base_url + resource_path }
    let(:api) { API.new(api_key: api_key) }
    let(:params) { nil }
    let(:response) { double(body: '{}') }

    let(:request) do
      {
        params: params,
        x_swu_api_key: api_key,
        x_swu_api_client: 'swoon 0.1.0',
        accept: 'application/json',
        content_type: 'application/json'
      }
    end

    before do
      [:get, :post, :put, :delete].each do |method|
        allow(RestClient)
          .to receive(method)
          .with(
            api_url,
            request
          )
          .and_return(response)
      end
    end

    describe '#templates' do
      context 'all templates' do
        describe '#fetch' do
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
            api.templates.fetch
          end
        end
      end

      context 'with id' do
        describe '#fetch' do
          let(:resource_path) { '/templates/some-id' }
          it 'requests GET /templates/some-id' do
            expect(RestClient)
              .to receive(:get)
              .with(
                api_url,
                request
              )
            api.templates('some-id').fetch
          end
        end

        describe '#locales' do
          context 'by id' do
            describe '#fetch' do
              let(:resource_path) { '/templates/some-id/locales/en-US' }
              it 'requests GET /templates/some-id/locales/en-US' do
                expect(RestClient)
                  .to receive(:get)
                  .with(
                    api_url,
                    request
                  )
                api.templates('some-id').locales('en-US').fetch
              end
            end
          end

          context 'Add Locale to Existing Template' do
            describe '#create' do
              let(:resource_path) { '/templates/some-id/locales' }
              it 'requests POST /templates/some-id/locales' do
                expect(RestClient)
                  .to receive(:post)
                  .with(
                    api_url,
                    MultiJson.dump(params),
                    x_swu_api_key: 'fake-api-key',
                    x_swu_api_client: 'swoon 0.1.0',
                    accept: 'application/json',
                    content_type: 'application/json'
                  )
                  .and_return(response)
                api.templates('some-id').locales.create(params)
              end
            end
          end

          context 'deleting' do
            describe '#delete' do
              let(:resource_path) { '/templates/some-id/locales/en-US' }
              it 'requests DELETE /templates/some-id/locales/en-US' do
                expect(RestClient)
                  .to receive(:delete)
                  .with(
                    api_url,
                    request.reject { |k| k == :params }
                  )
                api.templates('some-id').locales('en-US').delete
              end
            end
          end
          describe '#versions' do
            context 'all versions' do
              describe '#fetch' do
                let(:resource_path) { '/templates/some-id/locales/en-US/versions' }
                it 'requests GET /templates/some-id/locales/en-US/versions' do
                  expect(RestClient)
                    .to receive(:get)
                    .with(
                      api_url,
                      request
                    )
                  api.templates('some-id').locales('en-US').versions.fetch
                end
              end
            end
            context 'by id' do
              describe '#fetch' do
                let(:resource_path) { '/templates/some-id/locales/en-US/versions/some-version-id' }
                it 'requests GET /templates/some-id/locales/en-US/versions/some-version-id' do
                  expect(RestClient)
                    .to receive(:get)
                    .with(
                      api_url,
                      request
                    )
                  api.templates('some-id').locales('en-US').versions('some-version-id').fetch
                end
              end
            end

            context 'updating' do
              context '#update' do
                let(:resource_path) { '/templates/some-id/locales/en-US/versions/some-version-id' }
                let(:params) do
                  { foo: 'bar' }
                end

                it 'requests PUT /templates/some-id/locales/en-US/versions/some-version-id' do
                  expect(RestClient)
                    .to receive(:put)
                    .with(
                      api_url,
                      MultiJson.dump(params),
                      x_swu_api_key: 'fake-api-key',
                      x_swu_api_client: 'swoon 0.1.0',
                      accept: 'application/json',
                      content_type: 'application/json'
                    )
                    .and_return(response)
                  api.templates('some-id').locales('en-US').versions('some-version-id').update(params)
                end
              end
            end

            context 'creating' do
              describe '#create' do
                let(:resource_path) { '/templates/some-id/locales/en-US/versions' }
                it 'requests POST /templates/some-id/locales/en-US/versions' do
                  expect(RestClient)
                    .to receive(:post)
                    .with(
                      api_url,
                      MultiJson.dump(params),
                      x_swu_api_key: 'fake-api-key',
                      x_swu_api_client: 'swoon 0.1.0',
                      accept: 'application/json',
                      content_type: 'application/json'
                    )
                    .and_return(response)
                  api.templates('some-id').locales('en-US').versions.create(params)
                end
              end
            end
          end
        end
      end

      describe '#versions' do
        context 'all versions' do
          describe '#fetch' do
            let(:resource_path) { '/templates/some-id/versions' }
            it 'requests GET /templates/some-id/versions' do
              expect(RestClient)
                .to receive(:get)
                .with(
                  api_url,
                  request
                )
              api.templates('some-id').versions.fetch
            end
          end
        end
        context 'for id' do
          describe '#fetch' do
            let(:resource_path) { '/templates/some-id/versions/some-version-id' }
            it 'requests GET /templates/some-id/versions/some-version-id' do
              expect(RestClient)
                .to receive(:get)
                .with(
                  api_url,
                  request
                )
              api.templates('some-id').versions('some-version-id').fetch
            end
          end
        end

        context 'creating' do
          describe '#create' do
            let(:resource_path) { '/templates/some-id/versions' }
            it 'requests POST /templates/some-id/versions' do
              expect(RestClient)
                .to receive(:post)
                .with(
                  api_url,
                  MultiJson.dump(params),
                  x_swu_api_key: 'fake-api-key',
                  x_swu_api_client: 'swoon 0.1.0',
                  accept: 'application/json',
                  content_type: 'application/json'
                )
                .and_return(response)
              api.templates('some-id').versions.create(params)
            end
          end
        end
      end

      context 'creating' do
        describe '#create' do
          let(:resource_path) { '/templates' }
          it 'requests POST /templates' do
            expect(RestClient)
              .to receive(:post)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.templates.create(params)
          end
        end
      end

      context 'deleting' do
        describe '#delete' do
          let(:resource_path) { '/templates/some-id' }
          it 'requests DELETE /templates/some-id' do
            expect(RestClient)
              .to receive(:delete)
              .with(
                api_url,
                request.reject { |k| k == :params }
              )
            api.templates('some-id').delete
          end
        end
      end
    end



    describe '#send' do
      context 'with params' do
        let(:resource_path) { '/send' }
        let(:params) do
          { foo: 'bar' }
        end

        it 'requests POST /send with params' do
          expect(RestClient)
            .to receive(:post)
            .with(
              api_url,
              MultiJson.dump(params),
              x_swu_api_key: 'fake-api-key',
              x_swu_api_client: 'swoon 0.1.0',
              accept: 'application/json',
              content_type: 'application/json'
            )
            .and_return(response)
          api.send(params)
        end
      end
    end

    describe '#logs' do
      let(:params) { nil }

      context 'all logs' do
        let(:resource_path) { '/logs' }
        it 'requests GET /logs' do
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
          api.logs.fetch
        end
      end

      context 'by id' do
        describe '#fetch' do
          let(:resource_path) { '/logs/some-id' }
          it 'requests GET /logs/some-id' do
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
            api.logs('some-id').fetch
          end
        end

        describe '#events' do
          describe '#fetch' do
            let(:resource_path) { '/logs/some-id/events' }
            it 'requests GET /logs/some-id/events' do
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
              api.logs('some-id').events.fetch
            end
          end
        end
      end

      context 'resending' do
        let(:params) do
          { log_id: 'log_asdf123456qwerty' }
        end

        let(:resource_path) { '/resend' }
        let(:response) { double(body: '{}') }

        it 'requests POST /resend with params' do
          expect(RestClient)
            .to receive(:post)
            .with(
              api_url,
              MultiJson.dump(params),
              x_swu_api_key: 'fake-api-key',
              x_swu_api_client: 'swoon 0.1.0',
              accept: 'application/json',
              content_type: 'application/json'
            )
            .and_return(response)
          api.resend(params)
        end
      end
    end

    describe '#snippets' do
      context 'all snippets' do
        describe '#fetch' do
          let(:resource_path) { '/snippets' }
          it 'requests GET /snippets' do
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
            api.snippets.fetch
          end
        end
      end

      context 'with id' do
        describe '#fetch' do
          let(:resource_path) { '/snippets/some-id' }
          it 'requests GET /snippets/some-id' do
            expect(RestClient)
              .to receive(:get)
              .with(
                api_url,
                request
              )
            api.snippets('some-id').fetch
          end
        end
      end

      context 'creating' do
        describe '#create' do
          let(:resource_path) { '/snippets' }
          it 'requests POST /snippets' do
            expect(RestClient)
              .to receive(:post)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.snippets.create(params)
          end
        end
      end

      context 'updating' do
        describe '#update' do
          let(:resource_path) { '/snippets' }
          it 'requests PUT /snippets' do
            expect(RestClient)
              .to receive(:put)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.snippets.update(params)
          end
        end
      end

      context 'deleting' do
        describe '#delete' do
          let(:resource_path) { '/snippets/some-id' }
          it 'requests DELETE /snippets/some-id' do
            expect(RestClient)
              .to receive(:delete)
              .with(
                api_url,
                request.reject { |k| k == :params }
              )
            api.snippets('some-id').delete
          end
        end
      end
    end

    describe '#render' do
      context 'with params' do
        let(:resource_path) { '/render' }
        let(:params) do
          { foo: 'bar' }
        end

        it 'requests POST /render with params' do
          expect(RestClient)
            .to receive(:post)
            .with(
              api_url,
              MultiJson.dump(params),
              x_swu_api_key: 'fake-api-key',
              x_swu_api_client: 'swoon 0.1.0',
              accept: 'application/json',
              content_type: 'application/json'
            )
            .and_return(response)
          api.render(params)
        end
      end
    end

    describe '#esp_accounts' do
      context 'all esp_accounts' do
        let(:resource_path) { '/esp_accounts' }

        describe '#fetch' do
          it 'requests GET /esp_accounts' do
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
            api.esp_accounts.fetch
          end
        end
      end

      context 'creating' do
        describe '#create' do
          let(:resource_path) { '/esp_accounts' }
          it 'requests POST /esp_accounts' do
            expect(RestClient)
              .to receive(:post)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.esp_accounts.create(params)
          end
        end
      end

      context 'setting default' do
        describe '#set_default' do
          let(:resource_path) { '/esp_accounts/set_default' }
          let(:params) do
            { foo: 'bar' }
          end

          it 'requests POST /esp_account/set_default' do
            expect(RestClient)
              .to receive(:post)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.esp_accounts.set_default(params)
          end
        end
      end
    end
    describe '#customers' do
      context 'by email' do
        let(:resource_path) { '/customers/customer@example.com' }
        describe '#fetch' do
          it 'requests GET /customers/customer@example.com' do
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
            api.customers('customer@example.com').fetch
          end
        end
      end

      context 'creating' do
        describe '#create' do
          let(:resource_path) { '/customers' }

          let(:params) do
            { foo: 'bar' }
          end

          it 'requests POST /customers' do
            expect(RestClient)
              .to receive(:post)
              .with(
                api_url,
                MultiJson.dump(params),
                x_swu_api_key: 'fake-api-key',
                x_swu_api_client: 'swoon 0.1.0',
                accept: 'application/json',
                content_type: 'application/json'
              )
              .and_return(response)
            api.customers.create(params)
          end
        end
      end

      context 'deleting' do
        describe '#delete' do
          let(:resource_path) { '/customers/some-id' }
          it 'requests DELETE /customers/some-id' do
            expect(RestClient)
              .to receive(:delete)
              .with(
                api_url,
                request.reject { |k| k == :params }
              )
            api.customers('some-id').delete
          end
        end
      end

      context 'get logs' do
        let(:resource_path) { '/customers/customer@example.com/logs' }
        describe '#fetch' do
          context 'without params' do
            it 'requests GET /customers/customer@example.com/logs' do
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
              api.customers('customer@example.com').logs.fetch
            end
          end

          context 'with params' do
            let(:params) do
              {
                count: 10,
                created_lt: 'foo',
                created_gt: 'bar'
              }
            end

            it 'requests GET /customers/customer@example.com/logs?count=10&created_lt=foo&created_gt=bar' do
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
              api.customers('customer@example.com').logs.fetch(params)
            end
          end
        end
      end

      describe '#conversions' do
        context 'creating' do
          let(:resource_path) { '/customers/user@example.com/conversions' }
          describe '#create' do
            context 'without params' do
              it 'requests POST /customers/user@example.com/conversions' do
                expect(RestClient)
                  .to receive(:post)
                  .with(
                    api_url,
                    MultiJson.dump(params),
                    x_swu_api_key: 'fake-api-key',
                    x_swu_api_client: 'swoon 0.1.0',
                    accept: 'application/json',
                    content_type: 'application/json'
                  )
                  .and_return(response)
                api.customers('user@example.com').conversions.create
              end
            end

            context 'with params' do
              let(:params) do
                { foo: 'bar' }
              end
              it 'requests POST /customers/user@example.com/conversions' do
                expect(RestClient)
                  .to receive(:post)
                  .with(
                    api_url,
                    MultiJson.dump(params),
                    x_swu_api_key: 'fake-api-key',
                    x_swu_api_client: 'swoon 0.1.0',
                    accept: 'application/json',
                    content_type: 'application/json'
                  )
                  .and_return(response)
                api.customers('user@example.com').conversions.create(params)
              end
            end
          end
        end
      end
    end

    describe '#drip_campaigns' do
      context 'activating' do
        describe '#activate' do
          context 'with params' do
            let(:params) do
              { foo: 'bar' }
            end

            let(:resource_path) { '/drip_campaigns/some-id/activate' }
            it 'requests POST /drip_campaigns/some-id/activate' do
              expect(RestClient)
                .to receive(:post)
                .with(
                  api_url,
                  MultiJson.dump(params),
                  x_swu_api_key: 'fake-api-key',
                  x_swu_api_client: 'swoon 0.1.0',
                  accept: 'application/json',
                  content_type: 'application/json'
                )
                .and_return(response)
              api.drip_campaigns('some-id').activate(params)
            end
          end
        end
      end

      context 'deactivating' do
        describe '#deactivate' do
          context 'for a single campaign' do
            context 'with params' do
              let(:params) do
                { foo: 'bar' }
              end

              let(:resource_path) { '/drip_campaigns/some-id/deactivate' }
              it 'requests POST /drip_campaigns/some-id/deactivate' do
                expect(RestClient)
                  .to receive(:post)
                  .with(
                    api_url,
                    MultiJson.dump(params),
                    x_swu_api_key: 'fake-api-key',
                    x_swu_api_client: 'swoon 0.1.0',
                    accept: 'application/json',
                    content_type: 'application/json'
                  )
                  .and_return(response)
                api.drip_campaigns('some-id').deactivate(params)
              end
            end
          end
          context 'for all campaigns' do
            context 'with params' do
              let(:params) do
                { foo: 'bar' }
              end

              let(:resource_path) { '/drip_campaigns/deactivate' }
              it 'requests POST /drip_campaigns/deactivate' do
                expect(RestClient)
                  .to receive(:post)
                  .with(
                    api_url,
                    MultiJson.dump(params),
                    x_swu_api_key: 'fake-api-key',
                    x_swu_api_client: 'swoon 0.1.0',
                    accept: 'application/json',
                    content_type: 'application/json'
                  ).and_return(response)
                api.drip_campaigns.deactivate(params)
              end
            end
          end
        end
      end

      context 'by id' do
        describe '#fetch' do
          let(:resource_path) { '/drip_campaigns/some-id' }
          it 'requests GET /templates/some-id' do
            expect(RestClient)
              .to receive(:get)
              .with(
                api_url,
                request
              )
            api.drip_campaigns('some-id').fetch
          end
        end
      end
    end

    describe '#i18n' do
      describe '#pot' do
        context 'by tag' do
          describe '#fetch' do
            let(:resource_path) { '/i18n/pot/some-tag' }
            it 'requests GET /i18n/pot/some-tag' do
              expect(RestClient)
                .to receive(:get)
                .with(
                  api_url,
                  request
                )
              api.i18n.pot('some-tag').fetch
            end
          end
        end
      end
    end

    describe '#batch' do
      context 'with params' do
        let(:resource_path) { '/batch' }
        let(:params) do
          [{}]
        end

        it 'requests POST /batch with params' do
          expect(RestClient)
            .to receive(:post)
            .with(
              api_url,
              MultiJson.dump(params),
              x_swu_api_key: 'fake-api-key',
              x_swu_api_client: 'swoon 0.1.0',
              accept: 'application/json',
              content_type: 'application/json'
            )
            .and_return(response)
          api.batch(params)
        end
      end
    end
  end
end
