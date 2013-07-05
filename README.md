# Clivers

This gem has been built to ease switching multiple versions
of command line tools like Ruby, Python, Notepad++, etc. It
is not installer, it's a tool to switch already installed
software.

By using a configuration file and some conventions, the
tool will be able to locate your program and switch
between multiple version of the same command line tool by
tweaking the environment variables, usually simply the
PATH one.

## Installation

Install it via [rubygems](https://rubygems.org/gems/clivers)

    $ gem install clivers

## Usage

The first thing to do is to create a `.clivers` file in your home
directory. This file will contains the information needed
to know exactly where to look for programs. This file
has a strict format. Here an example of a `.clivers` file
that would be located at `~/.clivers`:

```yaml
python:
  path: "C:/Python"

ruby:
  path: "C:/Ruby"
  executables:
    - "bin/"

vagrant:
  path: "C:/Vagrant"
  executables:
   - "bin/"
```

 * **Important**
   Always use foward slash `/` when specifying
   path values, even on Windows.

Now, let see how to interpret this file and also how
Clivers interpret it.

The first level is the name of the command line tool to
manage. In our case, we have two, `python` and `ruby`.
The name will be the id of the program and is used,
by Clivers in his own cli commands, so choose a short
and sweet name.

The second level contains parameters that can be required
or optional and will be used by Clivers to setup your
environment correctly.

 * **Path**

   Can be specified with the key `path` and represents
   the location where all version of the program is
   installed. For the path to work correctly, you will
   need to follow certain conventions when installing
   the different version of the program. See section
   [Conventions](https://github.com/maoueh/clivers#conventions)
   below.

 * **Executables**

   Can be specified with the key `executables` and
   represents the different locations within a program
   that must be added to the PATH environment. This is
   an array so multiple executables path can be
   specified. Only directory are allowed for this
   parameter.

   When specifying an executable path, you can use `~` as
   a shortcut for your home directory and `.` as a
   shortcut for the program directory. Those shortcuts
   work even on Windows. See section
   [Conventions](https://github.com/maoueh/clivers#conventions)
   to understand where the program directory (`.`) will
   resolve to.

   As an example of a usage of `executables`, take the
   `ruby` program specified in the configuration file
   above. When installing Ruby, the executables are all
   found in the `bin/` directory within the program
   directory. So specifying the path with `bin/` (or
   `./bin/`) will ensure that it will be added to the
   PATH environment correctly.

### Conventions

To be able to work, Clivers will need to follow a
specific but loose convention when installing the
different command line tool software. The convention
is to install all the different versions in different
folders  all located at the same root where the each
folder name represents the version of the software.

Let take an a simple example with `Ruby`. You want
to work with two version of `Ruby`: `1.8.7` and
`1.9.3`. Here a possible layout you could have after
both installation:

```
    C:/Ruby
    ├── 1.8.7
        └── bin/
        └── ...
    └── 1.9.3
        └── bin/
        └── ...
```

Now, with this hierarchy and this config fragment in the
`.clivers` file:

```yaml
ruby:
  path: "C:/Ruby"
  executables:
    - "bin/"
```

Clivers will know that version `1.8.7` of Ruby is at
location `C:/Ruby/1.8.7` and that the `bin/` directory
within the location must be added to PATH when switching
version.

### Commands

This section list the various commands that can be executed
and their effects on your system.

TBC and more important TBI!

## Contributing

1. Fork it

2. Create either a fix branch or a feature branch
 * `git checkout -b fix-(name-here)`
 * `git checkout -b feature-(name-here)`

3. Commit your changes
 * `git commit -am 'Message describing the fix or feature'`

4. Push the branch into your repo
 * `git push origin feature-(name-here)`

5. Create new Pull Request
