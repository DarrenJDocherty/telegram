# Telegrams

A simple resource for RedM which allows players to send and receive telegrams. 

# Installation 

This resource requires mysql-async to communicate with the database. You can download it here: https://github.com/amakuu/mysql-async-temporary/.

- Extract telegrams into your resources folder
- Import telegrams.sql into your database
- Start the telegrams resource in your server.cfg

You can add new locations where telegrams can be by amending the locations table in the client.lua file. 

# Changelog

**Version 1.1 - 05/08/2020**

- Added direct message like behaviour
  - Telegrams now go direct to the player and are not visible to everyone
- Added a delete button for deleting old telegrams
- Added notification when a new telegram is received
