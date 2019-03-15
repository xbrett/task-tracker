# TaskTracker

Task tracker is an app for keeping track of all those pesky things to do. Users
can register, sign-in/out, and assign tasks to any of their underlings. Users can update
tasks, mark them complete, as well as update the time spent by adding a specific time block
or using the start/stop button when working on the task at hand.

# Design Choices

This app is supported by four database tables, users, tasks, managements, and timeblocks.
Users have a one-to-many relationship with tasks. Timeblocks have a one to many relationship
with tasks, as tasks can stopped and started at different times. Managements are a relationship 
between managers and underlings. A manager can have many underlings, underlings can have many
managers, and these can be layered. For the purpose of assigning tasks, a user is considered 
to be their own manager, so they can create tasks for themselves (this relationship is implicit
and not seen in the Management tab of the application). This seemed like the most 
practical decision in terms of usability for every user. Users can select who to assign a 
task to from a drop down list of themselves and their underlings. The manager-underling
relationship can be constructed in the Management tab, where a user is able to add an
underling from a dropdown list of other users. They are also able to delete any of these
relationships that they created. In this version, a user cannot see any information on 
the site unless they are registered and logged in.


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
