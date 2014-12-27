#!/bin/bash
docker rm -f puppet test01 2>/dev/null || true
docker run -d -P --name puppet --hostname puppet.localdomain ambakshi/puppetserver
sleep 2
PUPPET_PORT="$(docker inspect -f '{{range $i, $e := .NetworkSettings.Ports }}{{$p := index $e 0}}{{$p.HostPort}}{{end}}' puppet)"
PUPPET_SERVER="$(docker inspect -f '{{ .NetworkSettings.IPAddress  }}' puppet)"
docker logs puppet
echo -n "Waiting for PuppetServer: 0.0.0.0:$PUPPET_PORT / $PUPPET_SERVER:8140 .."
docker exec -ti puppet /bin/bash -c "until netstat -lnt | grep -q ':8140' ; do echo -n '.' ; sleep 2; done; echo ' DONE';"
for host in server-{001..010}; do
    docker rm -f $host 2>/dev/null || true
    docker run -ti -d --link puppet:puppet --name $host --hostname ${host}.localdomain ambakshi/puppetserver /usr/bin/puppet agent -t --debug --verbose --waitforcert 120
done
docker logs -f puppet
