# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
COPY /server/pubspec.* ./server/
COPY /core/pubspec.* ./core/
# Removing app from workspace
RUN sed -i '/- app/d' ./pubspec.yaml

RUN dart pub -C './server/' get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY server/ server/
COPY core/ core/
RUN dart pub get --offline
RUN mkdir bin/
RUN dart compile exe server/bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
