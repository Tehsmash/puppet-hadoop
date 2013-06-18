
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
}
