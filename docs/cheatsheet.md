# CHEAT SHEET MYSQL & POSTGRESQL

## **MySQL / MariaDB / Percona**

---

- Access MySQL

```
mysql -u [user] -p
ENTER PASSWORD: [password]
-----
mysql -u root -p
```

- Create user

```
CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

- Set Password

```
SET PASSWORD FOR '[username]'@'%' = '*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19';   ## password='password'
GRANT ALL PRIVILEGES ON *.* TO '[username]'@'%' WITH GRANT OPTION;
---
SET PASSWORD FOR 'admin'@'%' = '*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19';   ## password='password'
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
```

- Create/drop database

```
CREATE DATABASE [db_name];
DROP DATABASE [db_name];
```

- Create/drop table

```
CREATE TABLE [db_name.tbl_name];
DROP TABLE [db_name.tbl] IF EXIST;
```

- Show users & hosts

```
USE mysql;
SELECT host,user FROM user;
--------
+-----------+------------------+
| host      | user             |
+-----------+------------------+
| %         | zeroc0d3         |
| %         | root             |
| localhost | mysql.infoschema |
| localhost | mysql.session    |
| localhost | mysql.sys        |
| mysql     | root             |
+-----------+------------------+
```

- Change privileges

```
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
-----
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;
```

- Change access for all host

```
USE mysql;
UPDATE user set host='[hostname]' where user='[username]' and host='localhost';
FLUSH PRIVILEGES;
-----
UPDATE user set host='%' where user='root' and host='localhost';
FLUSH PRIVILEGES;
```

## **PostgreSQL**

---

- Access PostgreSQL

```
sudo -i -u postgres   ## or
su postgres
```

- Create/drop user

```
psql
createuser [username]
dropuser [username]
```

- Create/drop database

```
psql
createdb [db_name]
dropdb [db_name]
-----
\l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 db_name   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)
```

- Show users & roles

```
psql
\du
-----
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 zeroc0d3  | Superuser                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

- Change owner database

```
psql
\l    # list databases
ALTER DATABASE [db_name] OWNER TO '[username]';
```

- Change password user

```
psql
\du    # list users & roles
ALTER USER [username] PASSWORD '[password]';
```

- Change user roles

```
psql
\du    # list users & roles
ALTER ROLE [username] [role_name];  ## Superuser, Create role, Create DB, Replication, Bypass RLS
-----
ALTER ROLE deploy SUPERUSER;

                                    List of roles
 Role name  |                         Attributes                         | Member of
------------+------------------------------------------------------------+-----------
 deploy     | Superuser                                                  | {}
 zeroc0d3   | Superuser                                                  | {}
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

- Rename user

```
psql
\du    # list users & roles
ALTER USER [username] RENAME TO '[username_new]';


                                    List of roles
 Role name  |                         Attributes                         | Member of
------------+------------------------------------------------------------+-----------
 deploy_new | Superuser                                                  | {}
 zeroc0d3   | Superuser                                                  | {}
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

- Rename database

```
psql
\l    # list databases
ALTER DATABASE [db_name] RENAME TO '[db_name_new]';


                                    List of roles
 Role name  |                         Attributes                         | Member of
------------+------------------------------------------------------------+-----------
 deploy_new | Superuser                                                  | {}
 zeroc0d3   | Superuser                                                  | {}
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

- Alter Role

```
SUPERUSER           | NOSUPERUSER   – determine if the role is a superuser or not.
CREATEDB            | NOCREATEDB    – allow the role to create new databases.
CREATEROLE          | NOCREATEROLE  – allow the role to create or change roles.
INHERIT             | NOINHERIT     – determine if the role to inherit privileges of roles of which it is a member.
LOGIN               | NOLOGIN       – allow the role to log in.
REPLICATION         | NOREPLICATION – determine if the role is a replication roles.
BYPASSRLS           | NOBYPASSRLS   – determine if the role to by pass a row-level security (RLS) policy.
CONNECTION LIMIT limit              – specify the number of concurrent connection a role can made, -1 means unlimited.
PASSWORD 'password' | PASSWORD NULL – change the role’s password.
VALID UNTIL 'timestamp'             – set the date and time after which the role’s password is no long valid.
```

- Add Read-only user and permission with SELECT only

```
CREATE USER username WITH PASSWORD 'password';
GRANT CONNECT ON DATABASE db_name TO username;
GRANT USAGE ON SCHEMA schema TO username;
GRANT SELECT ON ALL TABLES IN SCHEMA schema TO username;
-- To make sure the user still able to view and select tables that created in the future
ALTER DEFAULT PRIVILEGES IN SCHEMA schema
GRANT SELECT ON TABLES TO username;
```

- To determine the size of a database

```
SELECT pg_size_pretty( pg_database_size('dbname') );
```

- To determine the size of a table in the current database

```
SELECT pg_size_pretty( pg_total_relation_size('tablename') );
```
