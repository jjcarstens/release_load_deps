# Example app for Elixir issue

This showcases the condition where the deps of a loaded dep are still
started in a release even though they are not direct deps with the parent.

## Explaination

The example here has a dep tree like so:

```sh
> a √ % mix deps.tree
a
└── b (../b)
    └── json ~> 1.0 (Hex package)
```

And `:b` is only loaded in the `:a` release (not started). Since `:b`
is only loaded, I expect `:json` to only load and not start as well.

To test, run:

```sh
> release_load_deps √ % cd a 
> a √ % mix do deps.get, release
> a √ % _build/dev/rel/a/bin/a start_iex 
Erlang/OTP 24 [erts-12.3] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1]

Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)
iex()1> Application.started_applications
[
  {:iex, 'iex', '1.13.4'},
  {:a, 'a', '0.1.0'},
  {:json, 'The First Native Elixir library for JSON encoding and decoding', '1.4.1'},
  {:logger, 'logger', '1.13.4'},
  {:sasl, 'SASL  CXC 138 11', '4.1.2'},
  {:elixir, 'elixir', '1.13.4'},
  {:compiler, 'ERTS  CXC 138 10', '8.1'},
  {:stdlib, 'ERTS  CXC 138 10', '3.17.1'},
  {:kernel, 'ERTS  CXC 138 10', '8.3.1'}
]
iex()2> 
```

Note `:json` is has be run.

Also confirm in the generated boot script with:

```sh
> a √ % cat _build/dev/rel/a/releases/0.1.0/start.script| grep "start_boot\,\[json"                             main
     {apply,{application,start_boot,[json,permanent]}},
```
