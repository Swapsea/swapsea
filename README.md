![Swapsea](app/assets/images/swapsea-logo-col-blk.png)

# Swapsea - Patrol Swaps Made Easy

Swapsea is an award-winning patrol swap system for Australian Surf Life Saving Clubs. Swapsea is Open Source to attract more [amazing volunteers](https://github.com/Swapsea/swapsea/graphs/contributors) - just like the Life Saving movement itself.

- See CONTRIBUTING.md for instructions on how to contribute to Swapsea.
- See LICENSE.md for the terms under which Swapsea is Open Source.

---

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Build Status](https://app.travis-ci.com/Swapsea/swapsea.svg?branch=staging)](https://app.travis-ci.com/Swapsea/swapsea)

## Frequently Asked Questions

See <https://www.swapsea.com.au/faq> for information about what Swapsea does, why it works and where it came from.

## Swapsea.com.au

Swapsea is offered for free to smaller clubs, or for a small hosting fee to larger clubs. See [swapsea.com.au](https://www.swapsea.com.au) for details.

You're welcome to host Swapsea yourself, provided you respect the name "Swapsea" and comply with the License obligations (share your modifications, keep the Copyright notices etc.)

## Development Environment Setup

Instructions for getting Swapsea working in a development environment.
First, install the required Gems:

```bash
bundle install
```

Then, install postgresql and create and initialise the database:

```bash
rake db:setup
```

Then run the Rails application in development:

```bash
rails server
```

Run just the browser tests with:

`RAILS_ENV=test bundle exec rspec spec/features/*.rb`

### Pre-commit hooks

We use pre-commit on every commit, to keep the code base nice and clean. Run manually with:

`pre-commit run --all-files`

### Rubocop

We use Rubocop to keep our Ruby code conventional. Run manually with:

`rubocop`

## Creating Demo Club Data

To create a demo club, use:

```bash
rake demo_club:populate['Swapsea Demo SLSC']
```

To destroy the demo club and all associated data, use:

```bash
rake demo_club:destroy['Swapsea Demo SLSC']
```

## Run All Tests

```bash
RAILS_ENV=test bundle exec rake db:test:load
RAILS_ENV=test bundle exec rake
```

---

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

The GNU General Public License is at [LICENSE](LICENSE).
