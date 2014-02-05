cute-problem-chooser
====================

Copyright 2014 - Abel Soares Siqueira - abel.s.siqueira@gmail.com
Gpl v3.

Based on the CUTEr Problem Chooser.
Scripts to select specific CUTE(r|st) problems, using the description provided
in the website.

Contributors of the original project:

* Leandro Prudente - lfprudente@gmail.com
* Raniere Gaia Costa da Silva - r.gaia.cs@gmail.com
* Me - my mail

* * *
Overview
--------

There will be some scripts to generate important information, the last updated
information files (so you don't have to run those scripts often), and a script
or program to separate the problems you want.

So far:

* __getsiflist.rb__: Retrieves from site [1] the list of problems with
   information and generates the file sif.url
* __sif.url__: File with all problems in the site, the number of variables,
  constraints, type of function, type of constraints, and some other
  informations. Check [2] for complete relation. This file is formatted for
  easy reading.

[1] http://www.cuter.rl.ac.uk/Problems/mastsif.shtml
[2] http://www.cuter.rl.ac.uk/Problems/classification.shtml


* * *
Installing and Running
----------------------

Generate (or update) `sif.url` with

    $ ./gensiflist.rb

* * *
License
-------

This software is available under the GNU Public License v.3,
which can be seen in COPYING.
Unless otherwise noted, all source is under this license.
