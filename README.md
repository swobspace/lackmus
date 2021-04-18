Lackmus
=======

Lackmus is a rails web application to process Suricata alerts. It collects
data from multiple sensors via rsyslog using the eve json format (available
since Suricata 2.0). 

Why? I don't like the classic approach: writing unified2 data with barnyard
directly to a central database. This needs installing barnyard on every sensor
and uses a separate communication channel. You can also do that with suricata
eve json format using a script to write json data to the central database, but
for what? In distributed environments a centralized syslog server is available 
in most cases. There is no need to open database write access from sensors on
your network boundaries. I prefer rsyslog: using an reliable transport via 
tcp, buffering events in case of lost connectivity and the ability to secure
the transport channel by tls (at the cost of a lot of additional configuration).

Here is the big picture:

1. (sensor): suricata sends an alert in eve json format vi syslog.
2. (sensor): rsyslog on the sensor sends all events to a central logging server
3. (server): rsyslog writes suricata related events to a database.
4. (server): Lackmus reads suricata events from database and deletes the
             event after processing it.

The primary goal is to filter out noise from your alert stream. This is done
by filters and actions. First you checkout one alert, mark one or more fields
(i.e. signature\_id, src\_id, dst\_id, proto and so on) and assign an action:
ignore (ignore the event but store it in Lackmus), drop (delete the event),
investigate (mark it for further investigation). Other actions such as send
a mail may follow. Filters may have a lifetime (may be ignore a specific 
signature\_id for a group of hosts for the next 8 days).

Filters can contain CIDR network addresses. Lackmus uses the native 
types INET and CIDR of PostgreSQL, so there is no choice for another
database.

**LACKMUS IS UNDER HEAVY DEVELOPMENT AND NOT USABLE YET. STAY TUNED ;-)**

Configure rsyslog
-----------------

### Rsyslog on the sensor (client)


```code
...
$ActionQueueType LinkedList
$ActionQueueFileName rsyslog.server
$ActionResumeRetryCount -1
$ActionQueueSaveOnShutdown on
$ActionQueueMaxDiskSpace 500M
*.notice                                @@central_server
kern.info                               @@central_server
```

### Central rsyslog server

Installation
-------------

Configuration
-------------

Developing
----------

If you like the idea and you have suggestions please send me an email (wob at swobspace dot net).

Licence
-------

Lackmus Copyright (C) 2016-2021  Wolfgang Barth

MIT license, see [LICENSE](LICENSE)

