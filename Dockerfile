FROM armswdev/arm-tools:bare-metal-compilers

RUN sudo rm /var/lib/apt/lists/lock && \
	sudo apt-get update -y && \
	sudo apt-get upgrade -y && \
	sudo apt-get -y --no-install-recommends install \
	zip \
	unzip \
  cmake
   
RUN sudo mkdir -p /src/workspace

VOLUME /src/workspace

CMD cd /src/workspace && \
	git clone --recursive https://github.com/lvgl/lvgl.git && \ 
	cd lvgl && \
	git checkout v8.3.6 && \
  cmake.exe \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_INSTALL_PREFIX="cmake-build/lvgl-installation" -B./cmake-build && \
  cd cmake-build && cmake --build . && cmake --install .  && \
	cd lvgl-installation && \
	zip --symlinks -r lvgl-v8.3.6.zip . && \
	exit
