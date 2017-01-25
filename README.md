QVD basic desktop image
=======================

It is a basic desktop with:
 * Libreoffice
 * Firefox
 * Thunderbird
 * Evince

Support for LXC images
======================

To create the tar.gz file importable into QVD (for LXC backends) please use the following
commands:

  sudo docker build -t theqvd:qvdimage-basicdesktop-ubuntu-mate-1604 .
  vmid=$(sudo docker run -d -t -i theqvd:qvdimage-basicdesktop-ubuntu-mate-1604 /bin/bash -c "read a; echo $a")
  docker export $vmid  | gzip -c > qvdimage-ubuntu-mate-16.04-basicdesktop.tgz
  sudo docker kill $vmid

And the importable image is qvdimage-ubuntu-16.04-basicdesktop.tgz

References
==========

More information about QVD can be found here: http://theqvd.com

Further docs are available here http://docs.theqvd.com
