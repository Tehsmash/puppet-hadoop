# File for formating all the disks

class hadoop::format {
	Exec {
		path => ["/bin", "/usr/bin", "/sbin"]
	}

#	file { "/sbin/format-drives-b-x":
#		ensure => present,
#		owner => "hduser",
#		group => "hadoop",
#		alias => "format-drives",
#		require => Package["parted"],
#		mode => "644",
#		source => "puppet:///modules/hadoop/scripts/format.sh",
#	}

#	exec { "format-commmand":
#		command => "/sbin/format-drives-b-x",
#		creates => "/dev/sdb1",
#		require => File['format-drives'],
#	}
	
	package { "parted":
		ensure => installed;
	}	

	define formatAndMountDrive {
		exec { "partition-table-${title}":
			command => "parted -a optimal --script /dev/sd${title} -- mktable gpt",
			creates => "/dev/sd${title}1",
			require => Package["parted"],
		}
		exec { "make-partition-${title}":
			command => "parted -a optimal --script /dev/sd${title} -- mkpart ext2 2 100%",
			creates => "/dev/sd${title}1",
			refreshonly => true,
			require => Package["parted"],
			subscribe => Exec["partition-table-${title}"]
		}
		exec { "make-filesystem-${title}":
			command => "mkfs.ext4 /dev/sd${title}1",
			require => Package["parted"],
			refreshonly => true,
			subscribe => Exec["make-partition-${title}"]
		}
		file { "/drive${title}":
			ensure => "directory",
			owner => "hduser",
			group => "hadoop",
			require => [ User["hduser"], Group["hadoop"] ],
			subscribe => Exec["make-filesystem-${title}"],
		}
		mount { "/drive${title}":
			device => "/dev/sd${title}1",
			ensure => "mounted",
			fstype => "ext4",
			options => "defaults",
			atboot => "true",
			require => File["/drive${title}"]
		}
		file { "/drive${title}/dfs/data":
			ensure => "directory",
			owner => "hduser",
			group => "hadoop",
			require => [ User["hduser"], Group["hadoop"] ],
			subscribe => Mount["/drive${title}"],
		}
	}

	formatAndMountDrive { ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x"]: }
}
