
# Homework

Homeworks can be used to solidify your knowledge of the material in each of the chapters. Most homeworks are based on running little **simulators,** which mimic some aspect of an operating system. For example, a disk scheduling simulator could be useful in understanding how different disk scheduling algorithms work. Some homeworks are just short programming exercises, allowing you to explore how real systems work.

For the simulators, the basic idea is simple: each of the simulators below let you both **generate problems** and **obtain solutions** for an infinite number of problems. Different random seeds can usually be used to generate different problems; using the `-c` flag computes the answers for you (presumably after you have tried to compute them yourself!).

Each simulator has a README file that explains how to run the simulator. Previously, this material had been included in the chapters themselves, but that was making the book too long. Now, all that is left in the book are the questions you might want to answer with the simulator; the details on how to run the simulator are all in the README.

**NEW: Video.** Each simulation will soon have a short video with one of the authors introducing the basic concepts of how to use the simulator to generate homework problems. Exciting, because you have to read less! Not exciting, because you have to hear us speak.


### Virtualization

 | **Topic of Interest** | **Chapter** | **Video** | **What To Do** |
 |----------------------:|------------:|----------:|:---------------|
 | _Process Intro_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-intro.pdf) | Video | Run [`process-run.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-CPU-Intro.tgz) |
 | _Process API_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-api.pdf) | Video | Write some code |
 | _Direct Execution_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-mechanisms.pdf) | Video | Write some code |
 | _Scheduling Basics_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched.pdf) | Video | Run [`scheduler.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Scheduler.tgz) |
 | _MLFQ Scheduling_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched-mlfq.pdf) | Video | Run [`mlfq.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-MLFQ.tgz) |
 | _Lottery Scheduling_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched-lottery.pdf) | Video | Run [`lottery.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Lottery.tgz) |
 | _VM API_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-api.pdf) | Video | Write some code |
 | _Relocation_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-mechanism.pdf) | [Video](http://youtu.be/mC3u99x8nqE) | Run [`relocation.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Relocation.tgz) |
 | _Segmentation_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-segmentation.pdf) | Video | Run [`segmentation.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Segmentation.tgz) |
 | _Free Space_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-freespace.pdf) | Video | Run [`freespace.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Freespace.tgz) |
 | _Paging_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-paging.pdf) | [Video](http://youtu.be/AhfSDqud3j4) | Run [`paging-linear-translate.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-LinearTranslate.tgz) |
 | _TLBs_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-tlbs.pdf) | Video | Write some code |
 | _Multi-level Paging_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-smalltables.pdf) | [Video](http://youtu.be/m1BQZPZduWk) | Run [`paging-multilevel-translate.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-MultiLevelTranslate.tgz) |
 | _Paging Mechanism_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-beyondphys.pdf) | Video | Run [`mem.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-BeyondPhys-Real.tgz) |
 | _Paging Policy_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-beyondphys-policy.pdf) | Video | Run [`paging-policy.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-Policy.tgz) |

### Concurrency

 | **Topic of Interest** | **Chapter** | **Video** | **What To Do** |
  |----------------------:|------------:|----------:|:---------------|
 | _Threads (Intro)_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-intro.pdf) | Video | Run [`x86.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-ThreadsIntro.tgz) |
 | _Threads (API)_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-api.pdf) | Video | Run [`main-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealAPI.tgz) |
 | _Threads (Locks)_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-locks.pdf) | Video | Run [`x86.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-ThreadsLocks.tgz) |
 | _Threads (CVs)_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-cv.pdf) | Video | Run [`main-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealCV.tgz) |
 | _Threads (Bugs)_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-bugs.pdf) | Video | Run [`vector-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealDeadlock.tgz) |

### Persistence

 | **Topic of Interest** | **Chapter** | **Video** | **What To Do** |
  |----------------------:|------------:|----------:|:---------------|
 | _Disks_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-disks.pdf) | Video | Run [`disk.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Disk.tgz) |
 | _RAID_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-raid.pdf) | Video | Run [`raid.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Raid.tgz) |
 | _FS Intro_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-intro.pdf) | Video | Write some code |
 | _FS Implement_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-implementation.pdf) | Video | Run [`vsfs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-VSFS.tgz) |
 | _FFS_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-ffs.pdf) | Video | Run [`ffs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-FFS.tgz) |
 | _AFS_ | [PDF](http://www.cs.wisc.edu/~remzi/OSTEP/dist-afs.pdf) | Video | Run [`afs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-AFS.tgz) |

