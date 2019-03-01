# TaskTracker

Task tracker is an app for keeping track of all those pesky things to do. Users
can register (or not) and assign tasks to any user in the system. Users can update
tasks and mark them complete as well as update the time spent up to the nearest
15-minutes. 

# Design Choices

This app is supported by two database tables, users and tasks which share a one
to many relationship respectively. When tasks are created they have to be assigned
to an existing user. This is enforced by the UI by way of a drop down. If a user
is deleted from the system, all tasks assigned to them are deleted as well to ensure
all data remains consistent. Time must be entered in increments of 15. This is enforced
by the UI with a integer selector that has a step set to 15 units. All of the styling
in this app was done using bootstrap 4. This app has a blue theme throughout.


# Running locally

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
