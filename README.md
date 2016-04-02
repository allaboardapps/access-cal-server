# Access Cal

* An accessible calendar system focused on inclusive events

## Deployment

1. GitHub
1. CircleCi
1. Application is hosted on a Heroku Pipeline named [access-cal-server](https://dashboard.heroku.com/pipelines/a3d041fe-dcf6-41b1-9cb4-7849b6f09202)
1. Promotion via access-cal-server-staging >> access-cal-server-production via `heroku pipelines:promote -r staging`
1. Post-deploy scripts are in `Procfile` after the `release:` instruction

## User Roles

* admin (Matt, Randy)
* staff
* client
* consumer

## Models

* User
* Organization
* OrganizationUser
* OrganizationGroup
* Group
* GroupUser
* Calendar
* CalendarUser
* Event
* EventUser
* Favorite
* Location
* Tag
* Transaction
* Notification
* Reservation

## Security Checks

* run `bundle outdated` > update gems with `bundle update` > run tests
* run `bundle-audit update`
* run `bundle-audit`
* run `brakeman`
* run `hakiri system:steps`
* run `hakiri manifest:generate` > `hakiri system:scan`
* run `hakiri gemfile:scan`

## Security References

* [How Do Ruby/Rails Developers Keep Updated on Security Alerts?](http://gavinmiller.io/2015/staying-up-to-date-with-security-alerts/)
* [Ruby Security Mailing List](https://groups.google.com/forum/#!forum/ruby-security-ann)
* [Rails Security Mailing List](https://groups.google.com/forum/?fromgroups#!forum/rubyonrails-security)
* [CVE Details](https://www.cvedetails.com/)
* [Hakiri service (fee-based)](https://hakiri.io/)
* [AppCanary service (fee-based)](https://appcanary.com/)
