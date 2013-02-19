# Boardwalk
#### *Ego driven design*
Boardwalk is a personal website framework built to encourage vanity.
Users can create their own board to fill with blog posts, photos, and other customizable widgets.
The layout is free form and custom to each user. The only limitation is the size of the board.

# Local Setup
Boardwalk is a Ruby on Rails application so the setup is minimal.
## Requirements
* Some *nix variant or OSX. I recommend Ubuntu Server or a Debian derivative.
* Ruby 1.9.3+, preferably using [RVM](https://rvm.io/).
* [Heroku Toolbelt](https://toolbelt.heroku.com/) (for production use.)
* Bundler; See Gemfile for gem dependencies.
* Node.js (Javascript driver)
* MongoDB

Clone the repository and run `bundle install`. You can use `bundle --without test` to omit any testing gems as they require additional libraries. The Boardwalk documentation assumes that you prepend `bundle exec` to your commands. I recommend an alias such as `alias be="bundle exec"` in your `.bashrc`/`.zshrc`.

Run `rake db:setup`. This rake command will load the database and seed any necessary defaults.

## Configuration
Make sure to edit your `cloudinary.yml` file with your [account credentials](https://cloudinary.com/users/register/free). The free tier should be more than enough for development purposes.

You should be all set to run Boardwalk with `be rails s`.

# Production Setup
While there is no reason you cannot setup Boardwalk to run on Passenger, the software is built to live on Heroku. Image hosting is done through [Cloudinary](https://github.com/cloudinary/cloudinary_gem) but uses [Carrierwave](https://github.com/jnicklas/carrierwave) to create image models. Carrierwave can be configured to store images locally or even resize images and send them off to S3, though that configuration is outside the scope of this guide.

## Heroku
Assuming you have an account and your credentials setup, setup is as easy as creating a new Heroku app. Make sure to add the MongoDB and Cloudinary addons at the Heroku control panel or with the Heroku toolbelt.

### Configuration
Boardwalk expects a few environment variables to run in production mode. You can add them on Heroku with the `heroku config:add` command.
#### Secret Keys
Your cookie token should be **at least 30 random characters**. Changing the cookie token will invalidate any existing Boardwalk cookies.

`heroku config:add SECRET_COOKIE_TOKEN=YOUR_SECRET_KEY`

# Contributing
File an issue report on GitHub if your unable to submit a Pull Request yourself.

## Pull Requests
Make sure your code matches the [style guide](https://github.com/bbatsov/ruby-style-guide).
I encourage clarity over fanciness; avoid awkward one-liners and unclear assignment.

# License
Boardwalk by Eric Wright is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
Based on a work at https://github.com/ericwright90/boardwalk.