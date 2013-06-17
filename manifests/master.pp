
class hadoop::master {
	Exec {
		path => ["/bin", "/usr/bin", "/sbin"]
	}

	file { "/home/hduser/.ssh/config":
		ensure => present,
		owner => "hduser",
		group => "hadoop",
		mode => "644",
		source => "puppet:///modules/hadoop/ssh/config",
		require => File["hduser-ssh-dir"],
	}

	exec { "${hadoop::params::hadoop_base}/hadoop-${hadoop::params::version}/bin/start-all.sh":
		user => "hduser",
		alias => "run-hadoop",
		creates => [ "/tmp/hadoop-hduser-namenode.pid", "/tmp/hadoop-hduser-tasktracker.pid" ], 
		refreshonly => true,
		require => [ File["hdfs-dir"], File['id_rsa'], File['id_rsa.pub'], File['auth_keys'], File ],
	}
}
