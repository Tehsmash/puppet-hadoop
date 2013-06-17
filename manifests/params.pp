# /etc/puppet/modules/hadoop/manafests/init.pp

class hadoop::params {

	include java::params

	$version = $::hostname ? {
		default			=> "1.1.2",
	}
        
	$master = $::hostname ? {
		default			=> "hadoopMaster.bigdata.lab",
	}
        
	$slaves = $::hostname ? {
		default			=> ["hadoopMaster.bigdata.lab", "hadoopSlave1.bigdata.lab", "hadoopSlave2.bigdata.lab", "hadoopSlave3.bigdata.lab", "hadoopSlave4.bigdata.lab", "hadoopSlave5.bigdata.lab", "hadoopSlave6.bigdata.lab", "hadoopSlave7.bigdata.lab", "hadoopSlave8.bigdata.lab", "hadoopSlave9.bigdata.lab", "hadoopSlave10.bigdata.lab", "hadoopSlave11.bigdata.lab", "hadoopSlave12.bigdata.lab", "hadoopSlave13.bigdata.lab", "hadoopSlave14.bigdata.lab", "hadoopSlave15.bigdata.lab"] 
	}

	$hdfsport = $::hostname ? {
		default			=> "8020",
	}

	$replication = $::hostname ? {
		default			=> "3",
	}

	$jobtrackerport = $::hostname ? {
		default			=> "8021",
	}
	$java_home = $::hostname ? {
		default			=> "${java::params::java_base}/jdk${java::params::java_version}",
	}
	$hadoop_base = $::hostname ? {
		default			=> "/opt/hadoop",
	}
	$hdfs_path = $::hostname ? {
		default			=> "/home/hduser/hdfs",
	}
}
