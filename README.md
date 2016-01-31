QVD basic desktop LXC image
===========================

This is how to build a basic desktop LXC image for QVD using Docker.

It is a basic desktop with:
 * Libreoffice
 * Firefox
 * Thunderbird
 * Evince

To create the tar.gz file importable into QVD please use the following
commands:

  sudo docker build -t theqvd:basicdesktop_xubuntu_1604 .
  vmid=$(sudo docker run -d -t -i theqvd:basicdesktop_xubuntu_1604 /bin/bash -c "read a; echo $a")
  docker export $vmid  | gzip -c > qvd-image-xubuntu-16.04-basicdesktop.tgz
  sudo docker kill $vmid

And the importable image is qvd-image-ubuntu-14.04-minimal.tgz

References
==========

More information about QVD can be found here: http://theqvd.com

Further docs are available here http://docs.theqvd.com
