# Swoon

 A wrapper for the [SendWithUs API](https://www.sendwithus.com/docs/api#templates).  Use at your own risk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swoon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swoon

## Usage

### Construct
#### ...with an API key (preferably yours)
```ruby
api = Swoon::API.new(api_key: 'YOUR_API_KEY')
```
### Templates API

#### Get a List of Templates
```ruby
api
  .templates
  .fetch
```

#### Get a specific template (all versions)
```ruby
api
  .templates('tem_1234567890')
  .fetch
```

#### Get a specific template (all versions) for a locale
```ruby
api
  .templates('tem_1234567890')
  .locales('en-US')
  .fetch
```

#### Get a list of template versions (with HTML/text)
```ruby
api
  .templates('tem_1234567890')
  .versions
  .fetch
```

#### Get a list of template versions (with HTML/text) for a locale
```ruby
api
  .templates('tem_1234567890')
  .locales('en-US')
  .versions
  .fetch
```

#### Get a specific version (with HTML/text)
```ruby
api
  .templates('tem_1234567890')
  .versions('some-version-id')
  .fetch
```

#### Get a specific version (with HTML/text) for a locale
```ruby
api
  .templates('tem_1234567890')
  .locales('en-US')
  .versions('some-version-id')
  .fetch
```

#### Update a Template Version
```ruby
api
  .templates('tem_1234567890')
  .versions('some-version-id')
  .update(
     html: '<html><head></head><body><h1>UPDATE</h1></body></html>',
     name: 'New Version',
     subject: 'edited!',
     text: 'sometext'
  )
```

#### Update a Template Version for a locale
```ruby
api
  .templates('tem_1234567890')
  .locales('en-US')
  .versions('some-version-id')
  .update(
     html: '<html><head></head><body><h1>UPDATE</h1></body></html>',
     name: 'New Version',
     subject: 'edited!',
     text: 'sometext'
  )
```

#### Create a New Template
```ruby
api
  .templates
  .create(
     html: '<html><head></head><body><h1>UPDATE</h1></body></html>',
     name: 'New Template',
     subject: 'Read me plz',
     text: 'sometext'
  )
```

#### Add Locale to Existing Template
```ruby
api
  .templates('tem_1234567890')
  .locales
  .create(params)
```
#### Create a New Template Version

```ruby
api
  .templates('tem_1234567890')
  .versions
  .create(params)
```

#### Delete a specific template

```ruby
api
  .templates('tem_1234567890')
  .delete
```

#### Delete a specific template for a locale
```ruby
api
  .templates('tem_1234567890')
  .locales('en-US')
  .delete
```

### Send API
#### Send an Email
```ruby
api
  .send(
    template: 'tem_A5RHVP6CnRbS34UysLjYHx',
    recipient: {
      name: 'John',
      address: 'user@email.com'
    },
    template_data: { amount: '$12.00' },
    cc: [
      { address: 'cc_one@email.com' },
      { address: 'cc_two@email.com' }
    ],
    bcc: [
      { address: 'bcc_one@email.com' },
      { address: 'bcc_two@email.com' }
    ],
    sender: {
      name: 'Company',
      address: 'company@company.com',
      reply_to: 'info@company.com'
    },
    tags: [
      'tag1',
      'tag2',
      'tag3'
    ],
    headers: {
      'X-HEADER-ONE': 'header-value'
    },
    inline: {
      id: 'cat.png',
      data: '{BASE_64_ENCODED_FILE_DATA}'
    },
    files: [
      {
        id: 'doc.txt',
        data: '{BASE_64_ENCODED_FILE_DATA}'
      },
      {
        id: 'stuff.zip',
        data: '{BASE_64_ENCODED_FILE_DATA}'
      }
    ],
    locale: 'en-US',
    esp_account: 'esp_1a2b3c4d5e',
    version_name: 'Version Name'
  )
```
### Log API
#### Get a List of all Logs
#### Get a specific log + metadata

#### Retrieve events for a specific log_id

#### Resend an existing Log

### Snippets API
#### Get all snippets
#### Get specific snippet
#### Creating a new snippet
#### Update an existing snippet
#### Delete an existing snippet

### Render API
#### Render a Template with Data

### ESP Account API

#### List all ESP Accounts
#### Add a new ESP Account
#### Set a given ESP Account as the default for sending emails

### Customers API
#### Get a Specific Customer
#### Creating/Updating a New Customer
#### Delete a Customer
#### Get Email Logs for a Customer

### Conversions API
#### Add Conversion to Customer

### Drip Campaigns API

#### Activate campaign for a customer
#### Deactivate a campaign for customer
#### Deactivate a customer from all campaigns
#### Get a list of campaigns
#### Get the details on a specific drip campaign

### Internationalization (i18n) API

#### Get translation package (.pot file)

### Batch API
#### Sample Batch (Multiple Sends)


### Errors


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

## License
