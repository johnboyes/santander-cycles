[![CircleCI](https://circleci.com/gh/johnboyes/santander-cycles.svg?style=shield)](https://circleci.com/gh/johnboyes/santander-cycles)
[![Code Climate](https://codeclimate.com/github/johnboyes/santander-cycles/badges/gpa.svg)](https://codeclimate.com/github/johnboyes/santander-cycles)
[![Dependency Status](https://gemnasium.com/badges/github.com/johnboyes/santander-cycles.svg)](https://gemnasium.com/github.com/johnboyes/santander-cycles)


# santander-cycles

Get notifications on [Slack](https://slack.com/is) for specific **[Santander Cycles](https://tfl.gov.uk/modes/cycling/santander-cycles) docking station availability in London**.

Example use case: you use the same bike docking stations every day to and from work; by deploying this app on [Heroku](https://heroku.com) you can set up (**free) [scheduled](https://elements.heroku.com/addons/scheduler) daily notifications** on Slack with the number of bikes and spaces available at those specific docking stations.

Simple Ruby app.

## Getting Started

- [Join Slack](https://slack.com/) (on their free plan) if you haven't already.  
You can set up a new team just for yourself to receive notifications such as this app provides.

- [Setup a Slack webhook](https://api.slack.com/incoming-webhooks) where the notifications will be sent to.

## Run locally

Prerequisites:

 * [Ruby](https://www.ruby-lang.org/en) (best installed with [rbenv](https://github.com/sstephenson/rbenv))

 * [Bundler](http://bundler.io)

 * [Heroku CLI (Command Line Interface)](https://devcenter.heroku.com/articles/heroku-command-line)

Create a `.env` file by copying the [`example.env`](example.env) and amend the environment variables in it:

```
SLACK_WEBHOOK_URL=put_your_slack_webhook_url_here
BIKEPOINT_API_URL=https://api.tfl.gov.uk/bikepoint
BIKEPOINT_COMMON_NAMES=Abbey Orchard Street, Westminster;Abbotsbury Road, Holland Park

```
* `SLACK_WEBHOOK_URL` use the URL provided by the [Slack webhook](https://api.slack.com/incoming-webhooks) you set up in the "Getting Started" section above.

* `BIKEPOINT_COMMON_NAMES` - You can keep the defaults to get up and running initially.  Then you can replace the defaults provided with a semi-colon separated list of the [docking station names](BIKEPOINTS.md) that you would like to be notified about. (The last entry in the list does not need a semi-colon after it but will work fine either way.)


Then:
* `bundle`

* `heroku local`

  This should send a notification to Slack.

## Deploying to Heroku

```
heroku create --region eu
heroku config:set SLACK_WEBHOOK=put_your_slack_webhook_url_here
heroku config:set BIKEPOINT_API_URL=https://api.tfl.gov.uk/bikepoint
heroku config:set BIKEPOINT_COMMON_NAMES=put_the_names_from_your_.env_file_here
git push heroku master
```

Alternatively, you can deploy your own copy of the app using the web-based flow:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

More information about Ruby on Heroku:

- [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby)
- [Heroku Ruby Support](https://devcenter.heroku.com/articles/ruby-support)

## Run the tests locally

  Just run `rspec` from the project's root folder
