<center>

<table>

<tbody>

<tr>

<td width="800pt">

<center><font color="#00aacc">

# Homework

</font></center>

Homeworks can be used to solidify your knowledge of the material in each of the chapters. Most homeworks are based on running little **simulators,** which mimic some aspect of an operating system. For example, a disk scheduling simulator could be useful in understanding how different disk scheduling algorithms work. Some homeworks are just short programming exercises, allowing you to explore how real systems work.

For the simulators, the basic idea is simple: each of the simulators below let you both **generate problems** and **obtain solutions** for an infinite number of problems. Different random seeds can usually be used to generate different problems; using the `-c` flag computes the answers for you (presumably after you have tried to compute them yourself!).

Note: All of these scripts are available individually [here.](http://www.cs.wisc.edu/~remzi/OSTEP/Homework/) Each single script is available as a gzip'd tar file; for example, type `tar xvzf HW-Scheduler.tgz` to unpack the `scheduler.py` script and an associated README.

Each simulator now has a README file that explains how to run the simulator. Previously, this material had been included in the chapters themselves, but that was making the book too long. Now, all that is left in the book are the questions you might want to answer with the simulator; the details on how to run the simulator are all in the README.

**NEW: Video.** Each simulation will soon have a short video with one of the authors introducing the basic concepts of how to use the simulator to generate homework problems. Exciting, because you have to read less! Not exciting, because you have to hear us speak.

A single [tar file](http://www.cs.wisc.edu/~remzi/OSTEP/Homework/all.tgz) containing all scripts is also available; type

<pre>tar xvzf all.tgz</pre>

to unpack all the scripts once you've downloaded the tar file.

### Virtualization

<table>
 <tbody>
 <tr>
 <td>**Topic of Interest**</td>
 <td>**Chapter**</td>
 <td>**Video**</td> 
> <td>**What To Do**</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Process Intro_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-intro.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`process-run.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-CPU-Intro.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Process API_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-api.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Write some code</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Direct Execution_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-mechanisms.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Write some code</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Scheduling Basics_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`scheduler.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Scheduler.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_MLFQ Scheduling_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched-mlfq.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`mlfq.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-MLFQ.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Lottery Scheduling_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/cpu-sched-lottery.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`lottery.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Lottery.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_VM API_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-api.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Write some code</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Relocation_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-mechanism.pdf)</td>
> 
> <td>[Video](http://youtu.be/mC3u99x8nqE)</td>
> 
> <td>Run [`relocation.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Relocation.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Segmentation_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-segmentation.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`segmentation.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Segmentation.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Free Space_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-freespace.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`freespace.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Freespace.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Paging_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-paging.pdf)</td>
> 
> <td>[Video](http://youtu.be/AhfSDqud3j4)</td>
> 
> <td>Run [`paging-linear-translate.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-LinearTranslate.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_TLBs_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-tlbs.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Write some code</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Multi-level Paging_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-smalltables.pdf)</td>
> 
> <td>[Video](http://youtu.be/m1BQZPZduWk)</td>
> 
> <td>Run [`paging-multilevel-translate.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-MultiLevelTranslate.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Paging Mechanism_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-beyondphys.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`mem.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-BeyondPhys-Real.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Paging Policy_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/vm-beyondphys-policy.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`paging-policy.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Paging-Policy.tgz)</td>
> 
> </tr>
> 
> </tbody>
> 
> </table>

### Concurrency

> <table>
> 
> <tbody>
> 
> <tr>
> 
> <td>**Topic of Interest**</td>
> 
> <td>**Chapter**</td>
> 
> <td>**Video**</td>
> 
> <td>**What To Do**</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Threads (Intro)_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-intro.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`x86.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-ThreadsIntro.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Threads (API)_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-api.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`main-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealAPI.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Threads (Locks)_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-locks.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`x86.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-ThreadsLocks.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Threads (CVs)_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-cv.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`main-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealCV.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Threads (Bugs)_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/threads-bugs.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`vector-*.c`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Threads-RealDeadlock.tgz)</td>
> 
> </tr>
> 
> </tbody>
> 
> </table>

### Persistence

> <table>
> 
> <tbody>
> 
> <tr>
> 
> <td>**Topic of Interest**</td>
> 
> <td>**Chapter**</td>
> 
> <td>**Video**</td>
> 
> <td>**What To Do**</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_Disks_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-disks.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`disk.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Disk.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_RAID_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-raid.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`raid.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-Raid.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_FS Intro_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-intro.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Write some code</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_FS Implement_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-implementation.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`vsfs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-VSFS.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_FFS_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/file-ffs.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`ffs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-FFS.tgz)</td>
> 
> </tr>
> 
> <tr>
> 
> <td>_AFS_</td>
> 
> <td>[PDF](http://www.cs.wisc.edu/~remzi/OSTEP/dist-afs.pdf)</td>
> 
> <td>Video</td>
> 
> <td>Run [`afs.py`](http://pages.cs.wisc.edu/~remzi/OSTEP/Homework/HW-AFS.tgz)</td>
> 
> </tr>
> 
> </tbody>
> 
> </table>

</td>

</tr>

</tbody>

</table>

</center>
