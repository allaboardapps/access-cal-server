# Access Cal

* An accessible calendar system focused on inclusive events

## System Dependencies

* Elastic Search
* Redis
* Puma
* CircleCi
* Heroku

## Deployment

1. Push your branch to GitHub with `git push origin [branch-name]`
1. CircleCi will build the app, run `rspec`, and scan style with `rubocop`.
1. When the `master` branch passes on the CircleCi build, the app will be deployed to the staging server on Heroku
1. The application is hosted on a Heroku Pipeline named [access-cal-server](https://dashboard.heroku.com/pipelines/a3d041fe-dcf6-41b1-9cb4-7849b6f09202)
1. You can promote the staging app to production (`access-cal-server-staging` to `access-cal-server-production`) via `heroku pipelines:promote -r staging`
1. Post-deploy tasks are referenced in the `Procfile` after the `release:` instruction
1. The deploy tasks are located in the `/lib/tasks/app.rake` file

## Documentation

* The `CHANGELOG.md` file is maintained by the [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator) gem
* To update the changelog, create a new version tag with `git tag -d v[semver]` and `git push --tags origin`, then run `github_changelog_generator`
* Yard
* Inch

## Testing

* rspec

## Continuous Integration

* CirleCi

## Code Style

* RuboCop

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
