RPM_DIST ?= el6
ITER ?= 2

FPM = fpm 
FPM_CMD = $(FPM) -s dir -t rpm -f --no-auto-depends -d java-1.7.0-openjdk --rpm-dist $(RPM_DIST) --iteration $(ITER) 

HADOOP_VERSION = 2.7.2
HADOOP_URL = http://www-us.apache.org/dist/hadoop/common/hadoop-$(HADOOP_VERSION)/hadoop-$(HADOOP_VERSION).tar.gz
HADOOP_DIST = hadoop-$(HADOOP_VERSION).tar.gz
HADOOP_RPM = java7-hadoop-$(HADOOP_VERSION)-$(ITER).$(RPM_DIST).x86_64.rpm

$(HADOOP_RPM): usr/share/java/hadoop
	$(FPM_CMD) -v $(HADOOP_VERSION) --name java7-hadoop usr etc

#usr/share/java/hadoop: hadoop-$(HADOOP_VERSION).tar.gz
usr/share/java/hadoop: hadoop-$(HADOOP_VERSION)-local.tar.gz
	mkdir -p usr/share/java
	tar zxf $< -C usr/share/java
	mv usr/share/java/hadoop-$(HADOOP_VERSION) $@

hadoop-$(HADOOP_VERSION).tar.gz:
	wget $(HADOOP_URL)

.PHONY: clean
clean:
	rm -f $(HADOOP_RPM) 
	rm -rf usr/share/java
