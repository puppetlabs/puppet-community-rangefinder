# Rangefinder
Predicts downstream impact of breaking file changes

## Overview

Rangefinder provides a command that can infer what a file defines and then tell
you what Forge modules use it. In other words, if you change the interface
provided by that file -- this will tell you what Forge modules must adapt to
that change.

If the file being evaluated is part of a Puppet module, then Rangefinder will
use that module's `metadata.json` to identify the name, and then use it to
fine-tune the way the results are presented.

It will separate output by the modules that we *know* will be impacted and those
which we can only *guess* that will be impacted. We can tell the difference based
on whether the impacted module has properly described dependencies in their own
`metadata.json` and whether `rangefinder` can figure out a dependency match.

This currently knows how to interpret and look up:

* Puppet 3.x functions
* Puppet 4.x functions
* Puppet language functions
* Classes
* Defined types
* Puppet resource types


## Installation

This is distributed as a Ruby gem. Simply `gem install puppet-community-rangefinder`


## Running

Just run the `rangefinder` command with a list of files. If it knows what the
file defines, then it will print out a list of Forge modules that use the thing
defined by that file.

You can also `--render-as` either `json` or `yaml`.

Example:

```
$ rangefinder lib/puppet/functions/mysql/password.rb           \
              lib/puppet/parser/functions/mysql_password.rb    \
              lib/puppet/parser/functions/mysql_strip_hash.rb  \
              lib/puppet/type/mysql_user.rb                    \
              manifests/db.pp                                  \
              manifests/server.pp
[mysql::password] is a _function_
==================================
The enclosing module is declared in 141 of 575 indexed public Puppetfiles

Breaking changes to this file WILL impact these modules:
  * openstack-ec2api (git://github.com/openstack/puppet-ec2api.git)
  * openstack-panko (git://github.com/openstack/puppet-panko.git)
  * openstack-octavia (git://github.com/openstack/puppet-octavia.git)
  * openstack-barbican (git://github.com/openstack/puppet-barbican.git)
  * openstack-heat (git://github.com/openstack/puppet-heat.git)
  * openstack-gnocchi (git://github.com/openstack/puppet-gnocchi.git)
  * openstack-murano (git://github.com/openstack/puppet-murano.git)
  * openstack-tacker (git://github.com/openstack/puppet-tacker.git)
  * openstack-ironic (git://github.com/openstack/puppet-ironic.git)
  * openstack-congress (git://github.com/openstack/puppet-congress.git)
  * openstack-mistral (git://github.com/openstack/puppet-mistral.git)
  * openstack-magnum (git://github.com/openstack/puppet-magnum.git)
  * openstack-neutron (git://github.com/openstack/puppet-neutron.git)
  * openstack-trove (git://github.com/openstack/puppet-trove.git)
  * openstack-glance (git://github.com/openstack/puppet-glance.git)
  * openstack-vitrage (git://github.com/openstack/puppet-vitrage.git)
  * openstack-designate (git://github.com/openstack/puppet-designate.git)
  * openstack-cinder (git://github.com/openstack/puppet-cinder.git)
  * openstack-zaqar (git://github.com/openstack/puppet-zaqar.git)
  * openstack-manila (git://github.com/openstack/puppet-manila.git)
  * openstack-aodh (git://github.com/openstack/puppet-aodh.git)
  * openstack-watcher (git://github.com/openstack/puppet-watcher.git)
  * openstack-keystone (git://github.com/openstack/puppet-keystone.git)
  * openstack-nova (git://github.com/openstack/puppet-nova.git)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)
  * openstack-ceilometer (git://github.com/openstack/puppet-ceilometer.git)
  * openstack-sahara (git://github.com/openstack/puppet-sahara.git)

[mysql_password] is a _function_
==================================
The enclosing module is declared in 141 of 575 indexed public Puppetfiles

Breaking changes to this file WILL impact these modules:
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * nubevps-wordpress (https://forge.puppetlabs.com/nubevps-wordpress/nubevps-wordpress)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * dmexe-rails (http://github.com/dima-exe/puppet-rails)
  * neillturner-wordpress (https://github.com/neillturner/puppet-wordpress)
  * mmitchell-puppetlabs_ironic (https://github.com/stackforge/puppet-ironic)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * mikegleasonjr-wordpress (https://github.com/mikegleasonjr/puppet-wordpress.git)
  * hfm-mha (git@github.com:hfm/puppet-mha.git)
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * hunner-wordpress (https://github.com/hunner/puppet-wordpress)
  * maxadamo-galera_maxscale (https://github.com/maxadamo/galera_maxscale)

Breaking changes to this file MAY impact these modules:
  * openstack-senlin (git://github.com/openstack/puppet-senlin.git)
  * openstack-placement (git://github.com/openstack/puppet-placement.git)
  * openstack-monasca (git://github.com/openstack/puppet-monasca.git)
  * narasimhasv-glance (git or puppet install)
  * Aethylred-puppetdashboard (https://github.com/Aethylred/puppet-puppetdashboard)
  * stackforge-heat (git://github.com/openstack/puppet-heat.git)
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * openstack-freezer (git://github.com/openstack/puppet-freezer.git)
  * openstack-cloudkitty (git://github.com/openstack/puppet-cloudkitty.git)
  * openstack-rally (git://github.com/openstack/puppet-rally.git)
  * ploperations-puppet (https://github.com/puppetlabs-operations/puppet-puppet)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * gousto-mysql (git://github.com/Gousto/puppetlabs-mysql.git)
  * openstack-tripleo (git://github.com/openstack/puppet-tripleo.git)
  * stackforge-keystone (git://github.com/openstack/puppet-keystone.git)
  * ULHPC-mysql (https://github.com/ULHPC/puppet-mysql)
  * stackforge-cinder (git://github.com/openstack/puppet-cinder.git)
  * brainfinger-dukesbank (git://github.com/teyo/brainfinger-dukesbank.git)
  * lcgdm-voms (https://github.com/cern-it-sdc-id/puppet-voms)
  * stackforge-neutron (git://github.com/openstack/puppet-neutron.git)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * openstack-glare (git://github.com/openstack/puppet-glare.git)
  * stackforge-ceilometer (git://github.com/openstack/puppet-ceilometer.git)
  * reidmv-pe_console (https://github.com/reidmv/puppet-module-pe_console)
  * openstack-tuskar (git://github.com/openstack/puppet-tuskar.git)
  * eshamow-pe_cert_auth (UNKNOWN)
  * vStone-percona (https://github.com/vStone/puppet-percona)
  * dmexe-deploy (http://github.com/dima-exe/puppet-deploy)
  * stackforge-glance (git://github.com/openstack/puppet-glance.git)
  * alanpetersen-moodle (https://github.com/alanpetersen/puppet-moodle.git)
  * stackforge-nova (git://github.com/openstack/puppet-nova.git)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * midonet-neutron (git://github.com/midonet/puppet-neutron.git)

[mysql_strip_hash] is a _function_
==================================
with no external impact.

The enclosing module is declared in 141 of 575 indexed public Puppetfiles

[mysql_user] is a _type_
==================================
The enclosing module is declared in 141 of 575 indexed public Puppetfiles

Breaking changes to this file WILL impact these modules:
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * kritz-vagrantlamp (https://github.com/kritznl/vagrantlamp)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * neillturner-wordpress (https://github.com/neillturner/puppet-wordpress)
  * openstack-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * mikegleasonjr-wordpress (https://github.com/mikegleasonjr/puppet-wordpress.git)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * hunner-wordpress (https://github.com/hunner/puppet-wordpress)
  * maxadamo-galera_maxscale (https://github.com/maxadamo/galera_maxscale)
  * stackforge-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * hfm-mha (git@github.com:hfm/puppet-mha.git)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)

Breaking changes to this file MAY impact these modules:
  * openstack-tripleo (git://github.com/openstack/puppet-tripleo.git)
  * Aethylred-puppetdashboard (https://github.com/Aethylred/puppet-puppetdashboard)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * tedivm-hieratic (https://github.com/tedivm/puppet-hieratic)
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * vStone-percona (https://github.com/vStone/puppet-percona)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * alanpetersen-moodle (https://github.com/alanpetersen/puppet-moodle.git)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * puppetlabs-mysql (git://github.com/puppetlabs/puppetlabs-mysql.git)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * gousto-mysql (git://github.com/Gousto/puppetlabs-mysql.git)

[mysql::db] is a _type_
==================================
The enclosing module is declared in 141 of 575 indexed public Puppetfiles

Breaking changes to this file WILL impact these modules:
  * shoekstra-owncloud (https://github.com/shoekstra/puppet-owncloud.git)
  * jefferyb-kualicoeus (https://github.com/jefferyb/kualicoeus)
  * SchnWalter-happydev (https://github.com/devgateway/happy-deployer/tree/master/puppet/modules/happydev)
  * mricon-bugzilla (https://github.com/mricon/puppet-bugzilla)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * aimonb-nexusis_mediawiki (https://github.com/NexusIS/puppet-mediawiki.git)
  * sgnl05-racktables (git://github.com/sgnl05/sgnl05-racktables.git)
  * gnubilafrance-redmine (https://github.com/gnubila-france/puppet-redmine)
  * leonardothibes-usvn (git://github.com/leonardothibes/puppet-usvn.git)
  * treydock-keycloak (git://github.com/treydock/puppet-module-keycloak.git)
  * forj-openfire (https://github.com/forj-oss/puppet-openfire)
  * cirrax-postfixadmin (https://github.com/cirrax/puppet-postfixadmin)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * hgkamath-owncloud (https://github.com/hgkamath/puppet-owncloud)
  * monkygames-beansbooks (https://bitbucket.org/monkygames/puppet-beansbooks.git)
  * rharrison-bacula (http://github.com/rharrison10/rharrison-bacula)
  * infnpd-ocpattrauth (https://baltig.infn.it/andreett/puppet-ocp-attribute-authority)
  * mmitchell-puppetlabs_ironic (https://github.com/stackforge/puppet-ironic)
  * fiddyspence-zabbix (https://github.com/fiddyspence/puppet-zabbix)
  * factorit-jasperreports_server (https://github.com/jbbrunsveld/jasperreports_server)
  * razorsedge-cloudera (https://github.com/razorsedge/puppet-cloudera.git)
  * aimonb-nexusis_gerrit (UNKNOWN)
  * akisakye-matomo (https://github.com/akisakye/matomo.git)
  * ccaum-autoami (git://github.com/ccaum/puppet-autoami)
  * wyrie-nagiosql (https://bitbucket.org/wyrie/puppet-nagiosql/src)
  * sensson-powerdns (https://github.com/sensson/puppet-powerdns)
  * puppetlabs-bacula (http://github.com/puppetlabs/puppetlabs-bacula)
  * oris-appserver (https://bitbucket.org/oris/env-puppet-module-appserver)
  * lboynton-gitlab (https://github.com/lboynton/puppet-gitlab)
  * alkivi-owncloud (https://github.com/alkivi-sas/puppet-owncloud)
  * binford2k-drupal (https://github.com/binford2k/binford2k-drupal)
  * geoffwilliams-r_profile (https://github.com/GeoffWilliams/r_profile)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * eelcomaljaars-friendica (https://devtools.maljaars-it.nl/opensource/puppet-friendica.git)
  * jsnshrmn-twlight (https://github.com/WikipediaLibrary/twlight_puppet)
  * cesnet-site_hadoop (https://github.com/MetaCenterCloudPuppet/cesnet-site_hadoop)
  * cirrax-roundcube (https://github.com/cirrax/puppet-roundcube)
  * martasd-mediawiki (git@github.com:martasd/puppet-mediawiki.git)
  * desalvo-bacula (https://github.com/desalvo/puppet-bacula)
  * martialblog-limesurvey (https://github.com/martialblog/puppet-limesurvey)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * bodgit-wordpress (https://github.com/bodgit/puppet-wordpress)
  * dsestero-sonarqube (https://github.com/dsestero/sonarqube.git)
  * marcdeop-ratticdb (https://github.com/marcdeop/ratticdb)
  * wyrie-snmptt (https://bitbucket.org/wyrie/puppet-snmptt/src)
  * othalla-nextcloud (https://github.com/othalla/puppet-nextcloud.git)
  * cnwr-cacti (https://github.com/cnwrinc/cnwr-cacti)
  * stesie-gluon (https://github.com/ffansbach/gluon-puppet)
  * bramwelt-patchwork (https://github.com/bramwelt/puppet-patchwork)
  * brucem-ezpublish (git://github.com/brucem/puppet-ezpublish.git)
  * icann-opendnssec (https://github.com/icann-dns/puppet-opendnssec)
  * dmcnicks-sympa (https://github.com/dmcnicks/dmcnicks-sympa.git)
  * hexmode-mediawiki (git@github.com:hexmode/puppet-mediawiki.git)
  * gnubilafrance-wisemapping (https://github.com/gnubila-france/puppet-wisemapping)
  * firefield-firefield (git@github.com:firefield/basic-rails-server.git)
  * blackknight36-bacula (https://github.com/blackknight36/puppet-bacula.git)
  * alkivi-zabbix (https://github.com/alkivi-sas/puppet-zabbix)
  * samuelson-custom_webapp (https://github.com/samuelson/samuelson-custom_webapp)

Breaking changes to this file MAY impact these modules:
  * tykeal-gerrit (https://github.com/tykeal/puppet-gerrit.git)
  * openstack-monasca (git://github.com/openstack/puppet-monasca.git)
  * soli-wrappers (https://github.com/solution-libre/puppet-wrappers)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * abaranov-sqlgrey (https://github.com/spacedog/puppet-sqlgrey)
  * theforeman-foreman (git://github.com/theforeman/puppet-foreman)
  * mwils-complete_wordpress (UNKNOWN)
  * rspiak-racktables (https://github.com/sgnl05/sgnl05-racktables)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * theforeman-foreman_proxy (git://github.com/theforeman/puppet-foreman_proxy)
  * erwbgy-wso2 (https://github.com/erwbgy/puppet-wso2.git)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * halyard-boxen (https://github.com/halyard/puppet-boxen)
  * echoes-wrappers (https://github.com/echoes-tech/puppet-wrappers)

[mysql::server] is a _class_
==================================
The enclosing module is declared in 141 of 575 indexed public Puppetfiles

Breaking changes to this file WILL impact these modules:
  * alexggolovin-lamp (https://github.com/alexggolovin/alexggolovin-lamp)
  * gajdaw-symfony (https://github.com/puppet-by-examples/puppet-symfony)
  * firm1-zds (https://github.com/firm1/zds-puppet)
  * SchnWalter-happydev (https://github.com/devgateway/happy-deployer/tree/master/puppet/modules/happydev)
  * jefferyb-kualicoeus (https://github.com/jefferyb/kualicoeus)
  * kritz-vagrantlamp (https://github.com/kritznl/vagrantlamp)
  * mricon-bugzilla (https://github.com/mricon/puppet-bugzilla)
  * sgnl05-racktables (git://github.com/sgnl05/sgnl05-racktables.git)
  * leonardothibes-phpmyadmin (git://github.com/leonardothibes/puppet-phpmyadmin.git)
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * gnubilafrance-redmine (https://github.com/gnubila-france/puppet-redmine)
  * forj-openfire (https://github.com/forj-oss/puppet-openfire)
  * nubevps-wordpress (https://forge.puppetlabs.com/nubevps-wordpress/nubevps-wordpress)
  * leonardothibes-usvn (git://github.com/leonardothibes/puppet-usvn.git)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * lcgdm-dpm (https://github.com/cern-it-sdc-id/puppet-dpm)
  * dmexe-rails (http://github.com/dima-exe/puppet-rails)
  * monkygames-beansbooks (https://bitbucket.org/monkygames/puppet-beansbooks.git)
  * dhollinger-devopsdays (https://gitlab.com/moduletux/devopsdays.git)
  * giavac-homer (https://github.com/giavac/giavac-homer)
  * sartiran-dpm (UNKNOWN)
  * aimonb-nexusis_mediawiki (https://github.com/NexusIS/puppet-mediawiki.git)
  * infnpd-ocpattrauth (https://baltig.infn.it/andreett/puppet-ocp-attribute-authority)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * fiddyspence-zabbix (https://github.com/fiddyspence/puppet-zabbix)
  * puppetlabs-awsdemo_profiles (https://github.com/puppetlabs/puppetlabs-awsdemo_profiles)
  * bflad-piwik (git://github.com/bflad/puppet-piwik.git)
  * continuent-tungsten (https://github.com/continuent/continuent-tungsten)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)
  * aimonb-nexusis_gerrit (UNKNOWN)
  * akisakye-matomo (https://github.com/akisakye/matomo.git)
  * wyrie-nagiosql (https://bitbucket.org/wyrie/puppet-nagiosql/src)
  * sensson-powerdns (https://github.com/sensson/puppet-powerdns)
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * factorit-jasperreports_server (https://github.com/jbbrunsveld/jasperreports_server)
  * thbe-bareos (https://github.com/thbe/puppet-bareos.git)
  * oris-appserver (https://bitbucket.org/oris/env-puppet-module-appserver)
  * lboynton-gitlab (https://github.com/lboynton/puppet-gitlab)
  * binford2k-drupal (https://github.com/binford2k/binford2k-drupal)
  * thbe-bacula (https://github.com/thbe/puppet-bacula.git)
  * geoffwilliams-r_profile (https://github.com/GeoffWilliams/r_profile)
  * lyonliang-otrs (https://github.com/ChinaShrimp/puppet-lyonliang-otrs.git)
  * gajdaw-phpmyadmin (https://github.com/puppet-by-examples/puppet-phpmyadmin)
  * madhukarn-percona_galera_cluster (https://github.com/madhu2852/Percona-Galera-Cluster.git)
  * martasd-mediawiki (git@github.com:martasd/puppet-mediawiki.git)
  * eelcomaljaars-friendica (https://devtools.maljaars-it.nl/opensource/puppet-friendica.git)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)
  * cesnet-site_hadoop (https://github.com/MetaCenterCloudPuppet/cesnet-site_hadoop)
  * jsnshrmn-twlight (https://github.com/WikipediaLibrary/twlight_puppet)
  * martialblog-limesurvey (https://github.com/martialblog/puppet-limesurvey)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * dsestero-sonarqube (https://github.com/dsestero/sonarqube.git)
  * marcdeop-ratticdb (https://github.com/marcdeop/ratticdb)
  * desalvo-bacula (https://github.com/desalvo/puppet-bacula)
  * glarizza-profiles (https://github.com/glarizza/puppet-profiles)
  * openstack-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * garystafford-sakila_mysql_db (https://github.com/garystafford/garystafford-sakila_mysql_db)
  * othalla-nextcloud (https://github.com/othalla/puppet-nextcloud.git)
  * cnwr-cacti (https://github.com/cnwrinc/cnwr-cacti)
  * icann-opendnssec (https://github.com/icann-dns/puppet-opendnssec)
  * brucem-ezpublish (git://github.com/brucem/puppet-ezpublish.git)
  * bramwelt-patchwork (https://github.com/bramwelt/puppet-patchwork)
  * hexmode-mediawiki (git@github.com:hexmode/puppet-mediawiki.git)
  * firefield-firefield (git@github.com:firefield/basic-rails-server.git)
  * puppetlabs-openstack (https://github.com/puppetlabs/puppetlabs-openstack.git)
  * garethr-wackopicko (git://github.com/garethr/garethr-wackopicko.git)
  * dmcnicks-sympa (https://github.com/dmcnicks/dmcnicks-sympa.git)
  * gnubilafrance-wisemapping (https://github.com/gnubila-france/puppet-wisemapping)
  * samuelson-custom_webapp (https://github.com/samuelson/samuelson-custom_webapp)

Breaking changes to this file MAY impact these modules:
  * jaysingh-mediawiki (jay)
  * jtopjian-havana (https://github.com/jtopjian/puppet-havana)
  * Aethylred-puppetdashboard (https://github.com/Aethylred/puppet-puppetdashboard)
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * narasimhasv-openstack (Install puppet module)
  * camptocamp-pacemaker (https://github.com/camptocamp/puppet-pacemaker)
  * karume-openstack (https://github.com/karume/puppetlabs-openstack.git)
  * hegdec-mediawiki (src)
  * abaranov-sqlgrey (https://github.com/spacedog/puppet-sqlgrey)
  * theforeman-foreman (git://github.com/theforeman/puppet-foreman)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * rspiak-racktables (https://github.com/sgnl05/sgnl05-racktables)
  * dbsrinivasulu-mediawiki (abcd)
  * reidmv-pe_console (https://github.com/reidmv/puppet-module-pe_console)
  * eshamow-pe_cert_auth (UNKNOWN)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * dmexe-deploy (http://github.com/dima-exe/puppet-deploy)
  * pbhutani-mediawiki (test)
  * byjupv-mediakwiki (mediakwiki)
  * theforeman-foreman_proxy (git://github.com/theforeman/puppet-foreman_proxy)
  * rocha-dpm (git://github.com/rochaporto/puppet-dpm)
  * erwbgy-wso2 (https://github.com/erwbgy/puppet-wso2.git)
  * willdurand-bazinga (UNKNOWN)
  * pltraining-dockeragent (https://github.com/puppetlabs/pltraining-dockeragent)
  * suvarnagodri-mediawiki (master)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * gururaj-mediawiki (mediawiki)
  * gerapeldoorn-nagiosxi (https://github.com/gerapeldoorn/puppet-nagiosxi)
```


## Configuration

Rangefinder will use the public dataset by default. If you're developing on the
data pipeline, you may configure BigQuery credentials in the `~/.rangefinder.conf`
file to point at private datasets instead.

Example configuration:

```
---
:gcloud:
  :dataset: <dataset>
  :project: <project>
  :keyfile: ~/.rangefinder/credentials.json
```

Contact [me](mailto:ben.ford@puppet.com) for credentials.


## Limitations

This is super early in development and has not yet been battle tested.


## Disclaimer

I take no liability for the use of this tool.


Contact
-------

binford2k@gmail.com

