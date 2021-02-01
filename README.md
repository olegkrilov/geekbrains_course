# MySQL Course Project
## Theme: Database for Home Appliances Service Center
### Oleg Karpenkov 2020


## Project structure

### Main [folder]
Includes files to deploy database:
- main.sql (database & tables creation)
- dictionaries.sql (fill tables with static data)

### Procedures [folder]
Includes files to setup database stored procedures:
- repair_procedures.sql (procedures to work with repairs data)
- storage_procedures.sql (procedures to work with storage & parts data)

### Test Scenarios [folder]
Includes 2 possible scenarios from "item received" to "item issued" states of the repair

### DB-Schema.png [file]
Visual representation for the database structure

### DB-Dump.sql [file]
Database dump


## Testing algorithm
- Clone project
- Establish connection to mysql server
- Run /Main/main.sql
- Run /Main/dictionaries.sql
- Run /Procedures/repair_procedures.sql
- Run /Procedures/storage_procedures.sql
- Run any file from /Test Scenarios or create own scenario
- Observe results


## Known issues
- Not found

