# Qvd client for IOS
# Copyright (C) 2015  theqvd.com trade mark of Qindel Formacion y Servicios SL
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM theqvd/qvdimageubuntu:minimalubuntu1604
MAINTAINER The QVD <docker@theqvd.com>

LABEL version="1.0"
LABEL description="This is a basic desktop Ubuntu VM image installation for QVD. It includes Mate Desktop, LibreOffice, Thunderbird, Firefox and Evince"

ENV DEBIAN_FRONTEND noninteractive
# packages
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial multiverse" > /etc/apt/sources.list.d/multiverse.list && \
  apt-get update && apt-get install -y \
  mate-desktop-environment \
  mate-desktop-environment-extras \
  cups \
  curl \
  evince \
  firefox \
  flashplugin-installer \
  language-selector-gnome \
  libreoffice \
  software-properties-common \
  thunderbird \
  && \
  add-apt-repository ppa:nilarimogard/webupd8 && \
  apt-get update && apt-get install -y \
  perl-qvd-client \
  && \
  apt-get -y remove blueman wpasupplicant modemmanager && \
  apt-get autoremove -y &&  apt-get clean

# Config
COPY vma.conf /etc/qvd/vma.conf
COPY wallpaper-qvd.jpg /usr/share/wallpapers/
COPY qvdstartx.sh /usr/local/bin/qvdstartx.sh
COPY notify.sh /usr/local/bin/notify.sh
COPY poweroff.sh /usr/local/bin/poweroff.sh
COPY screenlock.sh /usr/local/bin/screenlock.sh
COPY screenlockon.sh /usr/local/bin/screenlockon.sh
COPY screenlockoff.sh /usr/local/bin/screenlockoff.sh
COPY ubuntu-mate.gschema.override /usr/share/glib-2.0/schemas/ubuntu-mate.gschema.override
RUN glib-compile-schemas /usr/share/glib-2.0/schemas
RUN chmod 755 /usr/local/bin/qvdstartx.sh /usr/local/bin/notify.sh /usr/local/bin/poweroff.sh /usr/local/bin/screenlock.sh /usr/local/bin/screenlockon.sh /usr/local/bin/screenlockoff.sh 
# Disable services
RUN for i in cups-browsed  ;  do systemctl disable $i.service; done
# Cleanup
RUN echo "" > /etc/udev/rules.d/70-persistent-net.rules
CMD echo -e "This Docker container is used as a template to create a QVD Image\n" \
            "QVD is Linux Remote Desktop VDI system\n" \
            "\n" \
            "To create the tar.gz file importable into QVD please use the following commands:\n" \
	    "   sudo docker build -t theqvd/qvdimageubuntu:basicdesktop_ubuntu_mate_1604 .\n" \
            "   vmid=\$(sudo docker run -d -t -i theqvd/qvdimageubuntu:basicdesktop_ubuntu_mate_1604 /bin/bash -c \"read a; echo \$a\")\n" \
            "   docker export \$vmid  | gzip -c > qvd-image-ubuntu_mate-16.04-basicdesktop.tgz\n" \
            "   sudo docker kill \$vmid\n" \
            "\n" \
            "And the importable image is qvd-image-ubuntu_mate-16.04-basicdesktop.tgz\n" \
            "\n" \
            "For more information please check: \n" \
            "  * QVD web site:  http://theqvd.com and\n" \
            "  * Github repo https://github.com/theqvd/qvd-docker-image-basicdesktop-ubuntu-mate-1604.git/\n"
