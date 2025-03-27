[redis] REmote DIctionary Server
in-memory multi-model database famous for sub milisecond latency
- multi-model database supporting a variety of different database paradigsm through addons
- based on idea that cache can also be durable data store
- data is modified/read from main computer memory
- but at the same it stores data at the disk so it can be reconstructed as needed (supports snapshots/backups)
- every data point is the key followed by value

SET create a key with string value
SET hello world

GET read a key
GET hello

REDIS GRAPH
REDIS JSON
REDIS SEARCH
...
