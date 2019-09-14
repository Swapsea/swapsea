# Swapsea - Patrol Swaps Made Easy #

Swapsea is a superior, award-winning patrol swap system for Australian Surf Life Saving Clubs. Written in Ruby on Rails, it has powered swapsea.com.au for years and is now Open Source to attract more amazing volunteer [contributors](https://github.com/Swapsea/swapsea/graphs/contributors) - just like the Life Saving movement itself.

* See CONTRIBUTING.md for instructions on how to contribute to Swapsea.
* See LICENSE.md for the terms under which Swapsea is Open Source.

## Frequently Asked Questions ##

See <https://www.swapsea.com.au> for information about what Swapsea does, why it works and where it came from.

## Swapsea.com.au ##

Swapsea is operated as a managed Software-as-a-Service (SaaS) for a modest annual amount to cover hosting (at Heroku) and support. See [swapsea.com.au](https://www.swapsea.com.au) for details.

You're welcome to host Swapsea yourself, provided you respect the name "Swapsea" and comply with the License obligations (share your modifications, keep the Copyright notices etc.)

## Development Environment Setup ##

Instructions for getting Swapsea working in a development environment.
First, install the required Gems:

```bash
bundle install
```

Then create and initialise its database (need to have postgresql installed):

```bash
rake db:setup
```

Then run the Rails application in development:

```bash
rails server
```

## Creating Demo Club Data ##

To create a demo club called 'Swapsea SLSC', use:

```bash
rake demo_club:populate['Swapsea SLSC']
```

To destroy 'Swapsea SLSC' club and all associated data, use:

```bash
rake demo_club:destroy['Swapsea SLSC']
```

Notes:

* Be careful not to create a demo club with the same name as a real club.
* Awards created for demo are prefixed with DNS.
* Patrols will be name like 'Demo Patrol 1'
* Users will have a 10 digit ID, instead of 8 digits.
* Rosters are based on club name and roster name, so should not conflict.

---
Copyright (C) 2019  Mark Hudson, Alex Carroll, Ariell Friedman and Michael Bamford

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

The GNU General Public License is at [LICENSE](LICENSE).

Contact us at help@swapsea.com.au
