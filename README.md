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

* __selectproblems.rb__: Select problems using the options from `options.rc`, or
  the default options, or from the command line. The problems meeting the
  criteria are stored on the file `problem.list`.
* __options.rc__: Options for the `selectproblems.rb` script. If this file is
  erased, a default can be generated running the script.
* __problem.list__: Output from the script `selectproblems.rb`. Originally, this
  file does not exits.
* __getcodeinfo/getcodeinfo.sh__: Generates the file sif.dcd using the CUTEst
  interface in __getcodeinfo/__.
* __sif.dcd__: File with the same problems from `sif.bsc`, and information
  generated from the CUTEst interface. All information is as declared in the
  .SIF files, therefore hhe number of variables and constraints are identified
  as a number, i.e., not variable. 
* __getsiflist.rb__: Retrieves from site [1] the list of problems with
  information and generates the file sif.bsc
* __sif.bsc__: File with all problems in the site, the number of variables,
  constraints, type of function, type of constraints, and some other
  informations. Check [2] for complete relation. This file is formatted for
  easier reading/parsing. No information from this file is being used now
* __README.md__: This file.
* __LICENSE__: License file

[1] http://www.cuter.rl.ac.uk/Problems/mastsif.shtml

[2] http://www.cuter.rl.ac.uk/Problems/classification.shtml


* * *
Installing and Running
----------------------

The default use will be to select the problems. Edit the file options.rc and run
    
    $ ./selectproblems.rb

The problem list will be the file `problem.list`.

If you want to override any option with the command line you can use

    $ ./selectproblems.rb --<option> <value>
    
Where `<option>` must be a valid option. Run with `--usage` for list.

Generate (or update) `sif.bsc` with

    $ ./gensiflist.rb

Generate (or update) `sif.dcd` with

    $ cd getcodedinfo
    $ ./getcodedinfo.sh

WARNING: Generating `sif.dcd` requires a working installation of CUTEst and will
take a reasonable amount of time.

* * *
License
-------

This software is available under the GNU Public License v.3,
which can be seen in COPYING.
Unless otherwise noted, all source is under this license.
