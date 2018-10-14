Make Images
===========

To setup a custom image that you can then put another COW layer ontop of
for easy testing without messing up your environment use the following
command.

For more info on how to set this up read this post [here][1].

```
make custom-debian-base
```

After you have set it up create a layer ontop of it so you don't mess with
the base layer anymore using the following.

```
make cow
```

To generate a new layer if something gets messed up run `rm scratch.qcow` and
then just run `make cow` again to start fresh.

[1]: https://michaeljs1990.github.io/docs/linux/kerneldevel.html
