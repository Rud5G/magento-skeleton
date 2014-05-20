# JH Magento Skeleton Application #

This module is designed to alleviate the task of setting up a new project. It also brings in some new work flows and processes to make our lives easier.

The JH Magento Skeleton is a collection of tools and processes, it strings together some of the following great tools & projects:

1. [netz98 magerun](https://github.com/netz98/n98-magerun)
1. [Magento Composer Installer](https://github.com/magento-hackathon/magento-composer-installer)
1. [Capistrano](http://capistranorb.com/)
1. [Composer](https://getcomposer.org/)
1. And... probably more that i've missed!

The [Wiki](https://github.com/AydinHassan/magento-skeleton/wiki) should provide most of the documentation to get you started. Some of it is a little outdated and
refers to Bitbucket (Where this project was privately hosted) but that stuff should be self-explanatory, although I will updated it due time.

The main aim of this project was to get Magento Core out of the repository. This is achieved by using special packages with mappings. Please read here: [Core Package Creation](https://github.com/AydinHassan/magento-skeleton/wiki/Creating-a-Core-Package)

You can add as many Magento Versions as you want, to use them they must be added to your `.n98-magerun.yaml` file, and to deploy they must be added to your `composer.json`. 
Read [here](https://github.com/AydinHassan/magento-skeleton/wiki/Installing-a-Project-Locally).

Local installs, as shown [here](https://github.com/AydinHassan/magento-skeleton/wiki/Installing-a-Project-Locally) use `.n98-magerun.yaml` to load the packages. These can be any publically available Magento Repositories. Read
the file for an example of how to add custom repositories. Read [here](https://github.com/netz98/n98-magerun/wiki/Magento-installer) for more information.

For deploying, the Magento Version specified in the `composer.json` file will be used. This MUST be a repository with mappings as they are used to copy Magento from the `vendor` directory to the `htdocs` directory during deployment/

Remember that Enterprise Versions of Magento must be stored privately. We do this using Bitbucket and it works fine!

One of the great things to come out of this project is that you can test Magento upgrades so easily. You simply add the new version of Magento to your `.n98-magerun.yaml` config file, uninstall the current Magento version & reinstall.
It also discourages core hacks, as Magento is always applied last.

### Notes ###

This project is beta software at the minute. We are using it on a few sites in production and so far is proving to work well. There are bound to be bugs which need ironing out. Hopefully this tool can be a help to many others!

## Goals ##

1. [x] Stop putting Magento Source code in project repositories.
1. [x] Allow extensions to be installable by Composer.
1. [x] Simplify Project setup procedure.
1. [x] Utilise n98-magerun tool.
1. [x] Deploy with Capistrano.
1. [x] Provide a framework for Unit Testing


## Documentation ##

Head over to the -> [Wiki](https://bitbucket.org/jhhello/magento-skeleton/wiki/Home)

## Todo ##
- [x] Remove modman stuff in extension modules and replace with composer. Update Extension base repo and also export/carousel module.
- [x] Capistrano - Finish composer tasks.
- [x] Capistrano - Create task to run front end scripts
- [x] Capistrano - Create tasks for various magento admin tasks. Take a look at [Magentify](https://github.com/alistairstead/Magentify)
- [x] Capistrano - Create task for installing Magento (eg CE && EE)
- [x] Docs - Detail process for setting memory limit for MAMP PHP CLI access
- [x] Docs - How to install a Magento Extension (Include remarks about having to gitignore module files).
- [x] Docs - Using Composer
- [x] Docs - Setting up a new project
- [x] Docs - Installing project locally
- [x] Docs - Configuring a project for capistrano deploy
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
