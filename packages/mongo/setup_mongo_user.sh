#!/bin/sh

# Create a temporary JavaScript file with the commands
cat > mongo_setup.js << 'EOF'
disableTelemetry();
db = db.getSiblingDB('admin');
db.createUser({ 
  user: "nilesh", 
  pwd: "thatrandompassword", 
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" }, 
    { role: "readWriteAnyDatabase", db: "admin" }
  ] 
});
print("User 'nilesh' created successfully");
db.dropUser("root");
print("User 'root' removed successfully");
quit();
EOF

# Execute the commands using mongosh
mongosh --host localhost --port 27017 --authenticationDatabase admin -u root -p 123 --file mongo_setup.js

# Remove the temporary file
rm mongo_setup.js

echo "MongoDB user setup completed"