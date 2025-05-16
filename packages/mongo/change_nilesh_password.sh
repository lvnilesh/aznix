mongosh --host localhost --port 27017 --authenticationDatabase admin -u nilesh -p secret

use admin

db.changeUserPassword("nilesh", "anothersecret")