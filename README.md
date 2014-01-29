# JH Magento Skeleton Application #

This module is designed to alleviate the task of setting up a new project. It also brings in some new work flows and processes to make our lives easier.

## Dependency Graph

![](https://bitbucket.org/jhhello/magento-skeleton/wiki/deps.svg)

## Goals ##

1. [x] Stop putting Magento Source code in project repositories.
1. [x] Allow extensions to be installable by Composer.
1. [x] Simplify Project setup procedure.
1. [x] Utilise n98-magerun tool.
1. [x] Deploy with Capistrano.
1. [x] Provide a framework for Unit Testing


## Documentation ##

Head over to the -> [Wiki](https://bitbucket.org/AydinHassan/jh_magento_skeleton/wiki/Home)

## Todo ##
- [x] Remove modman stuff in extension modules and replace with composer. Update Extension base repo and also export/carousel module.
- [x] Capistrano - Finish composer tasks.
- [x] Capistrano - Create task to run front end scripts
- [x] Capistrano - Create tasks for various magento admin tasks. Take a look at [Magentify](https://github.com/alistairstead/Magentify)
- [x] Capistrano - Create task for installing Magento (eg CE && EE)
- [ ] Capistrano - Create tasks for setting up users/vhosts/directories
- [x] Docs - Detail process for setting memory limit for MAMP PHP CLI access
- [x] Docs - How to install a Magento Extension (Include remarks about having to gitignore module files).
- [x] Docs - Using Composer
- [x] Docs - Setting up a new project
- [x] Docs - Installing project locally
- [ ] Docs - Configuring a project for capistrano deploy
- [x] Docs - Using n98-magerun
- [x] Docs - Provide justification for goals of project
- [x] Docs - Unit Testing
- [x] Local Install Script - Option for installing sample data
- [x] Investigate and implement Composer autoloading into Magento Bootstrap process
- [x] Investigate loading DB credentials for Capistrano via local only file
- [x] Update Composer docs for autoloading and Magento Composer Installer

## Justifications ##
Below are sme justifications for the goals of the project to hopefully convince the haterz.

1. Putting all of Magento's source code in each projects repository is convoluted, it's understanable why people do it as Magento isn't built to be very modular and was around way before a decent package manager for PHP evolved. However there are processes we can follow which allow us keep Magento source code out of the project repositories. This will allow for easier code navigation, smaller repositories, easier upgrades, faster deploys and it stops core hacking. 

1. See 1. We don't need extensions in the repository, as long as we can specify a version we should use a dependency manager.

1. Installing a project is messy and inconsitent. We should have some processes or scripts to do it for us.

1. This tool is great and is used by lots of Professional Magento developers, we can greatly streamline our development process by using this tool. Lots of tasks to perform simple procedures in Magento which will save lots of time and help with debugging.

1. Because our deploys are too manual. We are programmers and what do we love best? Automation! YEAH! With Capistrano we can create tasks to do all the manual stuff we do at deploy, Update code, install dependencies, run scripts, clear cache, setup vhosts, upgrade magento versions and lots more.

1. Shouldn't need to justify this - saves debugging and bug fixing time - produces better, reusable code. Helps devs become better devs whilst creating a more solid product for the client? win.