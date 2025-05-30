Server vs Client
================

Let's enable more detailed information for observing our server and clients.
See documentation on [logging](https://hypershell.readthedocs.io/logging.html) for details.

```sh
hs config set logging.style detailed-compact --user
```


Server
------

So far we've only run `hsx` which includes the server and a single
client as within-process threads. Let's run the server in stand-alone mode.

> [!WARNING]
> Protect your cluster using a secure auth key!
> This happens automatically with `hsx` but you need to set this yourself when
> operating the server and clients in stand-alone mode.

Bind to `0.0.0.0` to allow remote connections (default: `localhost`)

```sh
hs server --forever --bind 0.0.0.0 -k mypass -r 2
```

Logs:

```
00-00:00:00.361 [login07]    DEBUG [server] Started
00-00:00:00.367 [login07]    DEBUG [server] Started (scheduler)
00-00:00:00.368 [login07]     INFO [server] Scheduler will run forever
00-00:00:00.368 [login07]    DEBUG [server] Started (confirm)
00-00:00:00.376 [login07]    DEBUG [server] Started (heartbeat)
00-00:00:00.377 [login07]    DEBUG [server] Started (receiver)
00-00:00:00.383 [login07]  WARNING [server] Database exists (303 previous tasks)
00-00:00:00.383 [login07]  WARNING [server] All tasks completed - did you mean to use the same database?
00-00:00:14.929 [login07]    DEBUG [server] Registered client (login07.gautschi.rcac.purdue.edu: 1b1f6832-ceb0-410e-a24d-9e15a8412fa8)

...
```


Client
------

That last message is only emitted once we've connected to it from some client.
Assuming we are on the same or a different server, we can specify the host and key
to connect and start running tasks locally.

```sh
hs client -N4 --host login07 -k mypass --capture
```

Logs:

```
00-00:00:00.311 [login07]    DEBUG [client] Started (1 executors)
00-00:00:00.852 [login07]    DEBUG [client] Started (scheduler: no timeout)
00-00:00:00.852 [login07]    DEBUG [client] Started (collector)
00-00:00:00.852 [login07]    DEBUG [client] Started (heartbeat)
00-00:00:00.852 [login07]    DEBUG [client] Started (executor-1)

...
```

Depending on what you've submitted to the database already, tasks should start flowing!
