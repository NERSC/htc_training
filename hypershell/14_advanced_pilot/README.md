Advanced Pilot
==============

This section outlines an automated deployment of HyperShell whereby the server and database
are hosted external to the HPC cluster and pilot jobs running the client are automatically
scaled out based on need - scaling to zero when no tasks remain.

In this scenerio we consider a hypothetical "XCore" user-facility operating under a similarly
named service account (username: xcore) with a collection of helper scripts.

Unlike some earlier examples in the tutorial, this section will require some modication to the
scripts to make it work. You likely do not have "xcore" as a username nor a running Postgres
or HyperShell server instance running under Kubernetes. You could deploy similar components
and modify the script to reflect these locations and credentials, or adapt them to have the
server running on the login node using SQLite under ~/.hypershell/lib/main.db or similar.

Copy the scripts from the included `bin` directory to your home directory `bin`.

```sh
mkdir -p ~/bin
cp bin/* ~/bin/
export PATH=$HOME/bin:$PATH
```

The `xcore-hs` wrapper script embeds configuration with the program for convenience and
to guard against accidentally breaking the pipeline.

The `xcore-pilot` and `xcore-autoscale` scripts are the most relavent here and are
the Slurm job script for launching a single scaling unit (i.e., pilot job) and
the submission programs, respectively. In a nutshell, we invoke `xcore-autoscale`
regularly, safely, and it submits a new `xcore-pilot` if necessary.

If a *cron* host is available you might consider something like the following that
would invoke the script every 60 seconds to check and scale.

```cron
* * * * * bash -l -c /home/xcore/bin/xcore-autoscale
```

The remaining scripts are merely convenience programs for getting at information
quickly. Running `xcore-jobs` pending or active pilot jobs. The `xcore-logs` script
locates and pages over recent task logs, optionally filter on something like a
task ID. And `xcore-kubectl` if you had the HyperShell server running under
Kubernetes (Docker) and had a local ~/.kube/config you could access a shell
within the running container.

