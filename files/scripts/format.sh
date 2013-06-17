DISKS="b c d e f g h i j k l m n o p q r s t u v w x" 

for i in ${DISKS}; do
	echo "Creating partitions on /dev/sd${i} ..."
	parted -a optimal --script /dev/sd${i} -- mktable gpt
	parted -a optimal --script /dev/sd${i} -- mkpart ext2 2 100%
	sleep 1
	echo "Formatting /dev/sd${i}1 ..."
	mkfs.ext4 /dev/sd${i}1
done 
