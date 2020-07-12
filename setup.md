---
title: Setup
---
Access to the system is necessary to undertake this course. It is assumed that attendees have a user account or have received a guest training account.

Some exercises are used in this course and are located in the login nodes cl1 and cl2 in /apps/Intro_to_OpenMP.2020.tar.gz. To copy and extract this file:

<pre style="color: silver; background: black;">
user@cl1: ~:$ cp /apps/Intro_to_OpenMP.2020.tar.gz /home/$USER
user@cl1: ~:$ tar -xzvf Intro_to_OpenMP.2020.tar.gz </pre>

If a node reservation is created users will need to add the following lines to their job scripts (confirm with your instructor):
~~~
#SBATCH --partition c_compute_md1
#SBATCH --reservation=training
#SBATCH --account=scw1148
~~~
{: .language-bash}

{% include links.md %}
