FROM ubuntu:focal-20230605

LABEL maintainer="sameer@damagehead.com"


RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \ 
&& wget -O- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/linux_signing_key.pub \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme sudo \
      fonts-dejavu fonts-liberation fonts-indic hicolor-icon-theme \
      libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
      libasound2 libglib2.0 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
      libgl1-mesa-glx libgl1-mesa-dri libstdc++6 nvidia-346 \
      gstreamer-1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
      gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
      google-chrome-stable chromium-browser firefox \
 && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && rm -rf /var/lib/apt/lists/*

COPY scripts/ /var/cache/browser-box/

COPY entrypoint.sh /sbin/entrypoint.sh

COPY confs/local.conf /etc/fonts/local.conf

RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
