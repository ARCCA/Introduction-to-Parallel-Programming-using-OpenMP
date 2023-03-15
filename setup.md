---
title: Setup
---
Access to the system is necessary to undertake this course. It is assumed that attendees have a user account or have received a guest training account.

Please follow the instructions below to obtain some example scripts:

1. Download [arc_openmp.zip][zip-file] and extract somewhere on Hawk. 
2. Extract the zip file and check the extracted directory

For example:

~~~
$ wget {{ site.url }}{{ site.baseurl }}/data/arc_openmp.zip
$ unzip arc_openmp.zip
$ ls arc_openmp
~~~
{: .language-bash}

A node reservation is created in partition c_compute_mdi1. To access it users need to specify in their job scripts:
~~~
#SBATCH --reservation=training
#SBATCH --account=scw1148
~~~
{: .language-bash}

[zip-file]: {{ page.root }}/data/arc_openmp.zip

## OpenMP

If not using Hawk, a modern compiler is required to support OpenMP such as Gcc, Intel or Clang.

{% include links.md %}
