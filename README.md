Kernel Devel
============

Helper scripts and docs around building and testing the kernel with QEMU

## Getting Started

The following commands will get you up and running quickly with a new kernel. The following
will pull down several git repos to get you started.

```
make install
```

Next you will want to configure your kernel with the following. After you have done so apply
anything special you need in linux/.config.

```
make linux-config
```

Now you can build your kernel with the following.

```
make linux-build
```

And finally you can prep your modules for setting up your initramfs with.

```
make modules
```
