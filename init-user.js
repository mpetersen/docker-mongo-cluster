db.auth('admin', 'admin');
db = db.getSiblingDB('my_database');
db.createUser({
  user: 'my_user',
  pwd: 'my_pass',
  roles: [
    {
      role: 'dbOwner',
      db: 'my_database',
    },
  ],
});
