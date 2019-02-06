# SolidusFacebookCatalog

### Introduction

The SolidusFacebookCatalog permit us to send our products catalog to facebook to create Dynamic Ads. Thanks to Facebook that has developed the <a href="https://developers.facebook.com/docs/business-sdk" target="_blank">Business SDK</a> and we use this to send our catalogs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'facebookbusiness'
gem 'solidus_facebook_catalog', git: 'https://github.com/2beDigital/solidus_facebook_catalog', branch: 'master'
```

If you want to send sales_price, please install:

```ruby
gem 'solidus_sales', git: 'https://github.com/2beDigital/solidus_sales', branch: 'master'
```

And then execute:

    $ bundle install
    $ bundle exec rails g solidus_facebook_catalog:install

Run migrations: 
	$ bundle exec rake db:migrate


### Introduction for Facebook SDK

<a href="https://github.com/facebook/facebook-ruby-business-sdk">Facebook Ruby SDK</a>

## Quick Start

Business SDK <a href="https://developers.facebook.com/docs/business-sdk/getting-started" target="_blank">Getting Started Guide</a>

## Pre-requisites

### Ruby Version
We developed this SDK using Ruby 2.0, and supports Ruby 2.0+, however, the SDK is not thread-safe at the moment.

### Register An App

To get started with the SDK, you must have an app
registered on <a href="https://developers.facebook.com/" target="_blank">developers.facebook.com</a>.

To manage the Marketing API, please visit your
<a href="https://developers.facebook.com/apps/<YOUR APP ID>/dashboard"> App Dashboard </a>
and add the <b>Marketing API</b> product to your app.

**IMPORTANT**: For security, it is recommended that you turn on 'App Secret
Proof for Server API calls' in your app's Settings->Advanced page.

### Obtain An Access Token

When someone connects with an app using Facebook Login and approves the request
for permissions, the app obtains an access token that provides temporary, secure
access to Facebook APIs.

An access token is an opaque string that identifies a User, app, or Page.

For example, to access the Marketing API, you need to generate a User access token
for your app and ask for the ``ads_management`` permission.

Refer to
<a href="https://developers.facebook.com/docs/facebook-login/access-tokens" target="_blank">
Access Token Guide</a> to learn more.

For now, we can use the
<a href="https://developers.facebook.com/tools/explorer" target="_blank">Graph Explorer</a>
to get an access token.

## Get Access Token 
* Go to <a href="https://developers.facebook.com/tools/explorer/">Graph API Explorer</a>
* Select correct App.
* Select User Token.
* Generate a user token with the necessary permissions.
* Click in icon info inside input token.
* Open token debugger from the Graph API Explorer
* Extend the access token. (Source = Web)
* Config this token in settings.

## Configuration

### Access Token
There are several ways to configure access token and app secret. If you only use one access token and app secret (example: an internal app managing only your own assets). You can set a global access token and app secret will be used across all requests

Config a ENV variable in a file like:

```bash
FB_access_token_app: 'YOUR_ACCESS_TOKEN'
FB_app_secret: 'YOUR_APP_SECRET'
```
Your initialize is like this:

```ruby
FacebookAds.configure do |config|
  config.access_token = ENV['FB_access_token_app']
  config.app_secret = ENV['FB_app_secret']
end
```

In your admin panel dashboard, access to Facebook Catalog, in settings config your business_Id, and can update your access_token.

## Reporting Bugs/Feedback
Please raise any issue on GitHub.
