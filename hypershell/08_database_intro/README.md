Configuration and Task Submission
=================================

Configuration
-------------

So far we've only run the `hs cluster` (`hsx`) in a transient, start-to-finish mode.
One of the distinguishing features of this tool is that fact that we can entirely
decouple task submission, scheduling, and execution as distrinct processes on
different machines.

Let's update our configuration instead of using environment variables in our script.
There is system, user, and local level configuration files.

* `/etc/hypershell.toml`        (system)
* `~/.hypershell/config.toml`   (user)
* `.hypershell/config.toml`     (local)

We can update our configuration strait from the command-line.

```sh
hs config set logging.level debug --user
```

Now that we've changed something, you can always check where a parameter is coming
from using the `hs config which` subcommand. This will show you the value,
where it came from with highest precedence, and what the default value is.

```sh
hs config which logging.level
```

Output:

```
debug (user: /home/glentner/.hypershell/config.toml | default: warning)
```

You can edit the file directly using `hs config edit --user`
(this assumes you have your `$EDITOR` environment variable set).

Database
--------

To enable a database for task persistence between invocations you can choose from
either SQLite or PostgreSQL. There are benefits (remote access, performance) to
choosing PostgreSQL but SQLite will get you really far and it is nice that it's
"just a file" on the file sytem.

For SQLite we only need to set a `file` path.
For PostgreSQL there are more credentials necessary to add.
See the online [documentation](https://hypershell.readthedocs.io/database.html) for details.

```sh
hs config set database.file ~/.hypershell/lib/main.db
```

This path can be basically anywhere. It's nice to keep it with the rest of your
global default `HYPERSHELL_SITE` data.

> [!WARNING]
> Putting the database on a networked filesystem can come with its challenges
> around file locking and synchronization. Having a native filesystem client helps.
> We use ZFS at Purdue for our /home filesytem on the HPC clusters and it works well.
> You might consider something like /tmp depending on your use-case and employ the
> `hs initdb --backup` tool to migrate task data to/from places on the filesystem safely.

Submit Tasks
------------

Submit tasks using the `hs submit` command.

This will read either a single command-line from the argument are process an entire
file of tasks depending on the invocation. See `hs submit --help` for details.

To submit a single task just give the positional arguments.

```sh
hs submit echo "hello world"
```

The database now contains one task and if/when the `hs server` (next section)
starts it will be scheduled for later execution when an `hs client` connects.

We can submit an entire collection of tasks at once from a file path.
If there is more than one position argument it is always treated as a single command line.
If there is only one positional argument it might be a program or a file.

Assuming we had some script `myprogram.py` in the current directory, this would
be considered a single task as the file is executable (assuming it is executable, haha).

```sh
hs submit ./myprogram.py
```

However, if that name is found on the file system and is _not_ executable it is considered
a collection of tasks - the same as we might pass directly into `hsx`.

```sh
hs submit <(seq 100)
```

