Random Item Script README
Overview
This script is designed for use with the QBCore framework. It provides functionality to give random items to players in the game, depending on the configured inventory system. The script supports multiple notification systems and inventory management systems, which can be customized through the Config settings.

The core features of the script include:

Giving a random item to each player at defined intervals.
Notifying players when they receive or lose an item.
Removing the item from players' inventories after a set period.
Support for different notification and inventory systems (QBCore, okok, codem, qs-notify, etc.).
Configuration
The behavior of the script can be customized via the Config table in the script. The configurable settings include:

Notify System
Defines which notification system should be used for notifications:

"none": No notifications are sent.
"qbcore": Uses QBCore's built-in notification system.
"okok": Uses okokNotify for notifications.
"codem": Uses codem_notify for notifications.
"qs": Uses qs-notify for notifications.
Inventory System
Defines which inventory system is used for adding/removing items:

"qs-inventory": Uses the qs-inventory system.
"qb-inventory": Uses the qb-inventory system.
"ox_inventory": Uses the ox_inventory system.
Item Removal Time
Controls how long an item will stay in the player's inventory before being removed (in seconds). Set in Config.RemoveAfter.

Debugging
Enable or disable debugging messages with Config.Debug. This will log detailed information about the script's actions (e.g., when an item is given or removed).

Interval
The time interval (in seconds) between each random item being given to players. Set in Config.Interval.

Items
A list of possible items that can be given to players, stored in Config.Items
