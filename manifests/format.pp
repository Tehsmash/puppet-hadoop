# File for formating all the disks

class hadoop::format( $drives = ["b"] ) {
	Exec {
		path => ["/bin", "/usr/bin", "/sbin"]
	}
	
	package { "parted":
		ensure => installed;
	}	

	define formatAndMountDrive {
#		mount { "/drive${title}":
#			device => "/dev/sd${title}1",
#			ensure => "absent",
#			fstype => "ext4",
#			options => "defaults",
#			atboot => "true",
#			alias => "unmountDrive${title}",
#		}
		exec { "partition-table-${title}":
			command => "parted -a optimal --script /dev/sd${title} -- mktable gpt",
			creates => "/dev/sd${title}1",
			require => Package["parted"],
#			subscribe => Mount["unmountDrive${title}"]
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
		file { "/drive${title}/dfs":
			ensure => "directory",
			owner => "hduser",
			group => "hadoop",
			require => [ User["hduser"], Group["hadoop"] ],
			subscribe => Mount["/drive${title}"],
		}
		file { "/drive${title}/dfs/data":
			ensure => "directory",
			owner => "hduser",
			group => "hadoop",
			require => [ User["hduser"], Group["hadoop"] ],
			subscribe => File["/drive${title}/dfs"],
		}
	}

	formatAndMountDrive { $drives : }
}
