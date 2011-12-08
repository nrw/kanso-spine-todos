## Kanso Spine Todos

These instructions assume you already have an instance of CouchDB running on localhost in admin party mode.

## How to run this example:

Install the `dev` branch of [Kanso](http://kansojs.org/)

```bash
git clone https://github.com/caolan/kanso.git -b dev
cd kanso
make && sudo make install
```

Clone this app and fetch dependencies

```bash
git clone https://github.com/nrw/kanso-spine-todos.git
cd kanso-spine-todos
kanso install
```

Push the app to CouchDB

```bash
kanso push http://localhost:5984/kanso-spine-todos
```

The app will be serving at `http://localhost:5984/kanso-spine-todos/_design/tasks/_rewrite/`
