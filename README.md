puppet-hadoop
=============

A puppet module built to completely install hadoop at the most basic usable level, based on bcarpio/puppet-hadoop, it had near complete overhaul and update.

Usage
-----

1. Install the module by cloning the repository into /etc/puppet/modules in folder named hadoop
2. In your site.pp: 

<pre><code>node hadoopBase {
    class { "hadoop": }
    class { "java": }  
}
    
node /hadoopMaster/ inherits hadoopBase {
    class { "hadoop::master": }
}
    
node /hadoopSlave/ inherits hadoopBase { }
</code></pre>

3. Once all the machines have successfully booted simply SSH into your master node, and run /opt/hadoop/hadoop/bin/start-all.sh 

Updating Hadoop
---------------

In order to update hadoop to the latest version, download the most recent tar.gz file from http://hadoop.apache.org/common/releases.html and place it into the modules/hadoop/files directory. After downloading make sure to update the params.pp file with the latest version number. 

Dependencies
------------

bcarpio/puppet-java module for putting the latest version of Java onto the hadoop machines you can find it here: https://github.com/bcarpio/puppet-java and then it needs to be cloned into a folder named 'java' under /etc/puppet/modules
