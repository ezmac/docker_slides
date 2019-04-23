# Docker talk for iwp: an outline of sorts
Background: Something is very deeply wrong with me and I want to give talks and help other people use cool tools. This means that after attending an IWP meeting, I went up to the organizer and told him I could give a talk.  Normally, I would duck out the back door when no one was looking.  I mean, I did that, but after, I went back and volunteered.

# I hate office, libre office, and everything that isn't compatible with a shell.

## History of Linux
When the universe was created, Jan 1 1970, Unix was still in development by the minor deities Sir Dennis M Ritchie and (deserves an honorific) Ken Thompson.  It's release to the public in 1973 forever changed the life of a young Linus Torvalds who would forever make computer nerds argue over complicated licensing models they don't fully understand.  By the time Torvalds released linux in 1991, Unix had been on the decline due, in part, to its high cost for home users, but the unix philosophy lived on in Linux.  In modern society, no one important uses unix. (OSX is a certified Unix, but who cares).  But this is not a talk on Unix.  Mainly because 40 minutes is not nearly long enough to explain the beauty of the unix philosophy.  This is about docker, which means it's about Linux.  If you know unix or solaris, just.. like.. hold your tongue, I know solaris jails are great, but find me a cloud provider who offers a solaris machine image.  Moving on.


At this point, you should talk about lxc, cgroups, jails, etc.  Show all the things docker depends on, then talk about how docker on release didn't have much else; then ask who cares.  cause the answer is everyone.



## History of Docker
In March 2013 at v0.9 Solomon Hykes Micdropped docker at Pycon to much fanfare.  In September, it had support from Redhat for use in RHEL and OpenShift.  In November 2014, Docker support was added to AWS EC2 in the form of ECS.  In December, IBM wanted some docker for their cloud.
### Key takeaways
From zero to Redhat in 6 months is huge.
From zero to AWS building an entire service around your tool in 13 months is massive.

### Haters to the left


## Jails


## Why does docker rock
cause sometimes you use python.  And on a server, you don't want to mess with anything because it's prod jenkins.  so you dev locally and WORKS ON MY MACHINE!

basically, it's a user friendly interface for a bunch of isolation primitives in linux.  cgroups and kernel namespaces namely
<ezmac> think of it as a virtual machine that shares the host kernel
