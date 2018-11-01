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

   
## Configuration

You must configure BigQuery credentials in the `~/.rangefinder.conf` file.

Example configuration:

```
---
:gcloud:
  :dataset: <dataset>
  :project: <project>
  :keyfile: ~/.rangefinder/credentials.json
```

Contact [me](mailto:ben.ford@puppet.com) for credentials.


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
Breaking changes to this file WILL impact these modules:
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)

[mysql_password] is a _function_
==================================
Breaking changes to this file MAY impact these modules:
  * eshamow-pe_cert_auth (UNKNOWN)
  * narasimhasv-glance (git or puppet install)
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * hfm-mha (git@github.com:hfm/puppet-mha.git)
  * ULHPC-mysql (https://github.com/ULHPC/puppet-mysql)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * dmexe-rails (http://github.com/dima-exe/puppet-rails)
  * dmexe-deploy (http://github.com/dima-exe/puppet-deploy)
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * vStone-percona (https://github.com/vStone/puppet-percona)
  * openstack-aodh (git://github.com/openstack/puppet-aodh.git)
  * openstack-heat (git://github.com/openstack/puppet-heat.git)
  * stackforge-heat (git://github.com/openstack/puppet-heat.git)
  * openstack-nova (git://github.com/openstack/puppet-nova.git)
  * stackforge-nova (git://github.com/openstack/puppet-nova.git)
  * hunner-wordpress (https://github.com/hunner/puppet-wordpress)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * midonet-neutron (git://github.com/midonet/puppet-neutron.git)
  * openstack-trove (git://github.com/openstack/puppet-trove.git)
  * maxadamo-galera_maxscale (https://github.com/maxadamo/galera_maxscale)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * mmitchell-puppetlabs_ironic (https://github.com/stackforge/puppet-ironic)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * gousto-mysql (git://github.com/Gousto/puppetlabs-mysql.git)
  * stackforge-cinder (git://github.com/openstack/puppet-cinder.git)
  * openstack-cinder (git://github.com/openstack/puppet-cinder.git)
  * openstack-glance (git://github.com/openstack/puppet-glance.git)
  * stackforge-glance (git://github.com/openstack/puppet-glance.git)
  * openstack-ironic (git://github.com/openstack/puppet-ironic.git)
  * openstack-manila (git://github.com/openstack/puppet-manila.git)
  * openstack-murano (git://github.com/openstack/puppet-murano.git)
  * openstack-sahara (git://github.com/openstack/puppet-sahara.git)
  * openstack-tuskar (git://github.com/openstack/puppet-tuskar.git)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * openstack-gnocchi (git://github.com/openstack/puppet-gnocchi.git)
  * stackforge-neutron (git://github.com/openstack/puppet-neutron.git)
  * openstack-neutron (git://github.com/openstack/puppet-neutron.git)
  * lcgdm-voms (https://github.com/cern-it-sdc-id/puppet-voms)
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * openstack-keystone (git://github.com/openstack/puppet-keystone.git)
  * stackforge-keystone (git://github.com/openstack/puppet-keystone.git)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * openstack-designate (git://github.com/openstack/puppet-designate.git)
  * brainfinger-dukesbank (git://github.com/teyo/brainfinger-dukesbank.git)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * neillturner-wordpress (https://github.com/neillturner/puppet-wordpress)
  * openstack-ceilometer (git://github.com/openstack/puppet-ceilometer.git)
  * stackforge-ceilometer (git://github.com/openstack/puppet-ceilometer.git)
  * alanpetersen-moodle (https://github.com/alanpetersen/puppet-moodle.git)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * reidmv-pe_console (https://github.com/reidmv/puppet-module-pe_console)
  * Aethylred-puppetdashboard (https://github.com/Aethylred/puppet-puppetdashboard)
  * mikegleasonjr-wordpress (https://github.com/mikegleasonjr/puppet-wordpress.git)
  * ploperations-puppet (https://github.com/puppetlabs-operations/puppet-puppet)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)
  * nubevps-wordpress (https://forge.puppetlabs.com/nubevps-wordpress/nubevps-wordpress)

[mysql_strip_hash] is a _function_
==================================
with no external impact.

[mysql_user] is a _type_
==================================
Breaking changes to this file MAY impact these modules:
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * hfm-mha (git@github.com:hfm/puppet-mha.git)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * kritz-vagrantlamp (https://github.com/kritznl/vagrantlamp)
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * vStone-percona (https://github.com/vStone/puppet-percona)
  * tedivm-hieratic (https://github.com/tedivm/puppet-hieratic)
  * hunner-wordpress (https://github.com/hunner/puppet-wordpress)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * maxadamo-galera_maxscale (https://github.com/maxadamo/galera_maxscale)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * gousto-mysql (git://github.com/Gousto/puppetlabs-mysql.git)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * neillturner-wordpress (https://github.com/neillturner/puppet-wordpress)
  * puppetlabs-mysql (git://github.com/puppetlabs/puppetlabs-mysql.git)
  * alanpetersen-moodle (https://github.com/alanpetersen/puppet-moodle.git)
  * openstack-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * stackforge-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * Aethylred-puppetdashboard (https://github.com/Aethylred/puppet-puppetdashboard)
  * mikegleasonjr-wordpress (https://github.com/mikegleasonjr/puppet-wordpress.git)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)

[mysql::db] is a _type_
==================================
Breaking changes to this file WILL impact these modules:
  * leonardothibes-usvn (git://github.com/leonardothibes/puppet-usvn.git)
  * puppetlabs-bacula (http://github.com/puppetlabs/puppetlabs-bacula)
  * factorit-jasperreports_server (https://github.com/jbbrunsveld/jasperreports_server)
  * hexmode-mediawiki (git@github.com:hexmode/puppet-mediawiki.git)
  * cirrax-roundcube (https://github.com/cirrax/puppet-roundcube)
  * gerardkok-ejbca (https://github.com/gerardkok/puppet-ejbca.git)
  * dmcnicks-sympa (https://github.com/dmcnicks/dmcnicks-sympa.git)
  * ccaum-autoami (git://github.com/ccaum/puppet-autoami)
  * bramwelt-patchwork (https://github.com/bramwelt/puppet-patchwork)
  * cnwr-cacti (https://github.com/cnwrinc/cnwr-cacti)
  * sgnl05-racktables (git://github.com/sgnl05/sgnl05-racktables.git)
  * dsestero-sonarqube (https://github.com/dsestero/sonarqube.git)
  * desalvo-bacula (https://github.com/desalvo/puppet-bacula)
  * bodgit-wordpress (https://github.com/bodgit/puppet-wordpress)
  * fiddyspence-zabbix (https://github.com/fiddyspence/puppet-zabbix)
  * eelcomaljaars-friendica (https://devtools.maljaars-it.nl/opensource/puppet-friendica.git)
  * jefferyb-kualicoeus (https://github.com/jefferyb/kualicoeus)
  * mricon-bugzilla (https://github.com/mricon/puppet-bugzilla)
  * wyrie-snmptt (https://bitbucket.org/wyrie/puppet-snmptt/src)
  * stesie-gluon (https://github.com/ffansbach/gluon-puppet)
  * forj-openfire (https://github.com/forj-oss/puppet-openfire)
  * jsnshrmn-twlight (https://github.com/WikipediaLibrary/twlight_puppet)
  * icann-opendnssec (https://github.com/icann-dns/puppet-opendnssec)
  * shoekstra-owncloud (https://github.com/shoekstra/puppet-owncloud.git)
  * marcdeop-ratticdb (https://github.com/marcdeop/ratticdb)
  * samuelson-custom_webapp (https://github.com/samuelson/samuelson-custom_webapp)
  * hgkamath-owncloud (https://github.com/hgkamath/puppet-owncloud)
  * wyrie-nagiosql (https://bitbucket.org/wyrie/puppet-nagiosql/src)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * treydock-keycloak (git://github.com/treydock/puppet-module-keycloak.git)
  * cesnet-site_hadoop (https://github.com/MetaCenterCloudPuppet/cesnet-site_hadoop)
  * alkivi-owncloud (https://github.com/alkivi-sas/puppet-owncloud)
  * razorsedge-cloudera (https://github.com/razorsedge/puppet-cloudera.git)
  * SchnWalter-happydev (https://github.com/devgateway/happy-deployer/tree/master/puppet/modules/happydev)
  * cirrax-postfixadmin (https://github.com/cirrax/puppet-postfixadmin)
  * martialblog-limesurvey (https://github.com/martialblog/puppet-limesurvey)
  * binford2k-drupal (https://github.com/binford2k/binford2k-drupal)
  * lboynton-gitlab (https://github.com/lboynton/puppet-gitlab)
  * maxadamo-galera_proxysql (https://github.com/maxadamo/galera_proxysql)
  * mmitchell-puppetlabs_ironic (https://github.com/stackforge/puppet-ironic)
  * sensson-powerdns (https://github.com/sensson/puppet-powerdns)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * alkivi-zabbix (https://github.com/alkivi-sas/puppet-zabbix)
  * brucem-ezpublish (git://github.com/brucem/puppet-ezpublish.git)
  * monkygames-beansbooks (https://bitbucket.org/monkygames/puppet-beansbooks.git)
  * aimonb-nexusis_gerrit (UNKNOWN)
  * rharrison-bacula (http://github.com/rharrison10/rharrison-bacula)
  * gnubilafrance-wisemapping (https://github.com/gnubila-france/puppet-wisemapping)
  * infnpd-ocpattrauth (https://baltig.infn.it/andreett/puppet-ocp-attribute-authority)
  * oris-appserver (https://bitbucket.org/oris/env-puppet-module-appserver)
  * aimonb-nexusis_mediawiki (https://github.com/NexusIS/puppet-mediawiki.git)
  * martasd-mediawiki (git@github.com:martasd/puppet-mediawiki.git)
  * firefield-firefield (git@github.com:firefield/basic-rails-server.git)
  * othalla-nextcloud (https://github.com/othalla/puppet-nextcloud.git)
  * gnubilafrance-redmine (https://github.com/gnubila-france/puppet-redmine)
  * wdijkerman-zabbix (https://github.com/dj-wasabi/puppet-zabbix.git)
  * puppet-zabbix (https://github.com/voxpupuli/puppet-zabbix.git)
  * geoffwilliams-r_profile (https://github.com/GeoffWilliams/r_profile)

Breaking changes to this file MAY impact these modules:
  * abaranov-sqlgrey (https://github.com/spacedog/puppet-sqlgrey)
  * erwbgy-wso2 (https://github.com/erwbgy/puppet-wso2.git)
  * theforeman-foreman (git://github.com/theforeman/puppet-foreman)
  * soli-wrappers (https://github.com/solution-libre/puppet-wrappers)
  * tykeal-gerrit (https://github.com/tykeal/puppet-gerrit.git)
  * jtopjian-cubbystack (https://github.com/jtopjian/puppet-cubbystack)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * lcgdm-dmlite (https://github.com/cern-it-sdc-id/puppet-dmlite)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
  * theforeman-foreman_proxy (git://github.com/theforeman/puppet-foreman_proxy)
  * rspiak-racktables (https://github.com/sgnl05/sgnl05-racktables)
  * echoes-wrappers (https://github.com/echoes-tech/puppet-wrappers)
  * mwils-complete_wordpress (UNKNOWN)
  * halyard-boxen (https://github.com/halyard/puppet-boxen)

[mysql::server] is a _class_
==================================
Breaking changes to this file WILL impact these modules:
  * martialblog-limesurvey (https://github.com/martialblog/puppet-limesurvey)
  * infnpd-creamce (https://github.com/italiangrid/puppet-creamce)
  * puppetlabs-awsdemo_profiles (https://github.com/puppetlabs/puppetlabs-awsdemo_profiles)
  * openstack-openstacklib (git://github.com/openstack/puppet-openstacklib.git)
  * samuelson-custom_webapp (https://github.com/samuelson/samuelson-custom_webapp)
  * kritz-vagrantlamp (https://github.com/kritznl/vagrantlamp)
  * infnpd-ocpattrauth (https://baltig.infn.it/andreett/puppet-ocp-attribute-authority)
  * alexggolovin-lamp (https://github.com/alexggolovin/alexggolovin-lamp)
  * aimonb-nexusis_mediawiki (https://github.com/NexusIS/puppet-mediawiki.git)
  * edestecd-mariadb (https://github.com/edestecd/puppet-mariadb.git)
  * puppetlabs-openstack (https://github.com/puppetlabs/puppetlabs-openstack.git)
  * gajdaw-symfony (https://github.com/puppet-by-examples/puppet-symfony)
  * fraenki-galera (https://github.com/fraenki/puppet-galera)
  * othalla-nextcloud (https://github.com/othalla/puppet-nextcloud.git)
  * thbe-bareos (https://github.com/thbe/puppet-bareos.git)
  * oris-appserver (https://bitbucket.org/oris/env-puppet-module-appserver)
  * ULHPC-slurm (https://github.com/ULHPC/puppet-slurm)
  * binford2k-drupal (https://github.com/binford2k/binford2k-drupal)
  * jefferyb-kualicoeus (https://github.com/jefferyb/kualicoeus)
  * fiddyspence-zabbix (https://github.com/fiddyspence/puppet-zabbix)
  * desalvo-bacula (https://github.com/desalvo/puppet-bacula)
  * jsnshrmn-twlight (https://github.com/WikipediaLibrary/twlight_puppet)
  * forj-openfire (https://github.com/forj-oss/puppet-openfire)
  * firefield-firefield (git@github.com:firefield/basic-rails-server.git)
  * bflad-piwik (git://github.com/bflad/puppet-piwik.git)
  * mricon-bugzilla (https://github.com/mricon/puppet-bugzilla)
  * garystafford-sakila_mysql_db (https://github.com/garystafford/garystafford-sakila_mysql_db)
  * gajdaw-phpmyadmin (https://github.com/puppet-by-examples/puppet-phpmyadmin)
  * leonardothibes-phpmyadmin (git://github.com/leonardothibes/puppet-phpmyadmin.git)
  * gnubilafrance-wisemapping (https://github.com/gnubila-france/puppet-wisemapping)
  * cnwr-cacti (https://github.com/cnwrinc/cnwr-cacti)
  * cesnet-site_hadoop (https://github.com/MetaCenterCloudPuppet/cesnet-site_hadoop)
  * geoffwilliams-r_profile (https://github.com/GeoffWilliams/r_profile)
  * eelcomaljaars-friendica (https://devtools.maljaars-it.nl/opensource/puppet-friendica.git)
  * garethr-wackopicko (git://github.com/garethr/garethr-wackopicko.git)
  * thbe-bacula (https://github.com/thbe/puppet-bacula.git)
  * sartiran-dpm (UNKNOWN)
  * lboynton-gitlab (https://github.com/lboynton/puppet-gitlab)
  * nubevps-wordpress (https://forge.puppetlabs.com/nubevps-wordpress/nubevps-wordpress)
  * monkygames-beansbooks (https://bitbucket.org/monkygames/puppet-beansbooks.git)
  * aimonb-nexusis_gerrit (UNKNOWN)
  * bramwelt-patchwork (https://github.com/bramwelt/puppet-patchwork)
  * factorit-jasperreports_server (https://github.com/jbbrunsveld/jasperreports_server)
  * puppetlabs-wordpress_app (https://github.com/puppetlabs/puppetlabs-wordpress_app)
  * wyrie-nagiosql (https://bitbucket.org/wyrie/puppet-nagiosql/src)
  * gnubilafrance-redmine (https://github.com/gnubila-france/puppet-redmine)
  * sgnl05-racktables (git://github.com/sgnl05/sgnl05-racktables.git)
  * glarizza-profiles (https://github.com/glarizza/puppet-profiles)
  * tscopp-jss (https://github.com/tscopp/puppet-jss/issues)
  * giavac-homer (https://github.com/giavac/giavac-homer)
  * sensson-powerdns (https://github.com/sensson/puppet-powerdns)
  * lyonliang-otrs (https://github.com/ChinaShrimp/puppet-lyonliang-otrs.git)
  * madhukarn-percona_galera_cluster (https://github.com/madhu2852/Percona-Galera-Cluster.git)
  * lcgdm-dpm (https://github.com/cern-it-sdc-id/puppet-dpm)
  * continuent-tungsten (https://github.com/continuent/continuent-tungsten)
  * dsestero-sonarqube (https://github.com/dsestero/sonarqube.git)
  * dmcnicks-sympa (https://github.com/dmcnicks/dmcnicks-sympa.git)
  * brucem-ezpublish (git://github.com/brucem/puppet-ezpublish.git)
  * firm1-zds (https://github.com/firm1/zds-puppet)
  * marcdeop-ratticdb (https://github.com/marcdeop/ratticdb)
  * gerardkok-ejbca (https://github.com/gerardkok/puppet-ejbca.git)
  * leonardothibes-usvn (git://github.com/leonardothibes/puppet-usvn.git)
  * hexmode-mediawiki (git@github.com:hexmode/puppet-mediawiki.git)
  * johanek-redmine (https://github.com/johanek/johanek-redmine)
  * SchnWalter-happydev (https://github.com/devgateway/happy-deployer/tree/master/puppet/modules/happydev)
  * martasd-mediawiki (git@github.com:martasd/puppet-mediawiki.git)

Breaking changes to this file MAY impact these modules:
  * pltraining-dockeragent (https://github.com/puppetlabs/pltraining-dockeragent)
  * suvarnagodri-mediawiki (master)
  * narasimhasv-openstack (Install puppet module)
  * pbhutani-mediawiki (test)
  * erwbgy-wso2 (https://github.com/erwbgy/puppet-wso2.git)
  * karume-openstack (https://github.com/karume/puppetlabs-openstack.git)
  * reidmv-pe_console (https://github.com/reidmv/puppet-module-pe_console)
  * willdurand-bazinga (UNKNOWN)
  * camptocamp-pacemaker (https://github.com/camptocamp/puppet-pacemaker)
  * rocha-dpm (git://github.com/rochaporto/puppet-dpm)
  * rspiak-racktables (https://github.com/sgnl05/sgnl05-racktables)
  * dbsrinivasulu-mediawiki (abcd)
  * vshn-uhosting (https://github.com/vshn/uhosting)
  * lcgdm-lcgdm (https://github.com/cern-it-sdc-id/puppet-lcgdm)
  * eshamow-pe_cert_auth (UNKNOWN)
  * gerapeldoorn-nagiosxi (https://github.com/gerapeldoorn/puppet-nagiosxi)
  * jtopjian-havana (https://github.com/jtopjian/puppet-havana)
  * theforeman-foreman_proxy (git://github.com/theforeman/puppet-foreman_proxy)
  * eNovance-cloud (https://github.com/enovance/puppet-openstack-cloud)
  * gururaj-mediawiki (mediawiki)
  * dmexe-deploy (http://github.com/dima-exe/puppet-deploy)
  * theforeman-foreman (git://github.com/theforeman/puppet-foreman)
  * abaranov-sqlgrey (https://github.com/spacedog/puppet-sqlgrey)
  * byjupv-mediakwiki (mediakwiki)
  * devopera-domysqldb (https://github.com/devopera/puppet-domysqldb)
```
 

## Limitations

This is super early in development and has not yet been battle tested.

## Disclaimer

I take no liability for the use of this tool.

Contact
-------

binford2k@gmail.com

