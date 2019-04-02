## 52n Project & Component Navigator

1. `docker-compose up`
1. install media wiki via `http://localhost:8080` (check SemanticDrilldown, SemanticMediaWiki and Cargo in the installation hooks; database connection as per docker-compose)
1. store the downloaded LocalSettings.php
1. stop, adjust docker-compose to mount the LocalSettings.php, start
1. Initialize the pages (`Category:Project`, `Template:Project`)
1. bash into the container, execute the commands in `custom-commands-after-docker-startup.bash` OR use the nice feature in the `Template:Project` "Create Database"
1. Create a project (e.g. `ProjectFunnyName`) using the template
1. Drill down!
1. Easy, right?

