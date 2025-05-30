HyperShell Tutorial
===================


Each of the sections included here incrementally add some new aspect to the tool.
This is not an exhaustive tutorial but covers the essentials to get you started.


## Install

HyperShell is a Python-based command-line tool installable from PyPI or GitHub
(along with some macOS/Linux package managers). We recommend isolating it within
a virtual environment. The venerable [pipx](https://pipx.pypa.io/stable/) is very
capable but we prefer [uv](https://docs.astral.sh/uv/getting-started/installation/) for user installations.

To install `uv` on macOS or Linux:

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

To install HyperShell:

```sh
uv tool install hypershell --python 3.13
```

There is an optional dependency on `psycopg2` for PostgreSQL support which has
some library dependencies specific to your platform. To install HyperShell
with support for the PostgreSQL database backend:

```sh
uv tool install 'hypershell[postgres]' --python 3.13
```

Ask your HPC center admins to create a module if not already available.
There are some special considerations more easily deployed for users as a system tool.


## Online

* Code at [github.com/hypershell/hypershell](https://github.com/hypershell/hypershell).
* Docs at [hypershell.readthedocs.io](https://hypershell.readthedocs.io).
* Website at [hypershell.org](https://hypershell.org). (coming soon)
* Discord at [discord.gg/wmv5gyUfkN](https://discord.gg/wmv5gyUfkN).

