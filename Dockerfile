FROM commonlispbr/roswell
RUN apt update && apt install libsdl1.2-dev libsdl-ttf2.0-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev -y
WORKDIR /app
COPY . .
RUN /app/build.ros
