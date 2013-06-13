puppet-hadoop
=============

A puppet module built to completely install hadoop at the most basic usable level, based on bcarpio/puppet-hadoop, it had near complete overhaul and update.

Usage
-----

1. Install the module by cloning the repository into /etc/puppet/modules in folder named hadoop
2. In your site.pp: 

<code><pre>
    node hadoopBase {
      class { "hadoop": }
      class { "java": }
    }
    node /hadoopMaster/ inherits hadoopBase {
      class { "hadoop::master": }
    }

    node /hadoopSlave/ inherits hadoopBase { }
</code></pre>

3. Once all the machines have successfully booted simply SSH into your master node, and run /opt/hadoop/hadoop/bin/start-all.sh 

