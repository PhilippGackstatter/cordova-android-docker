# Cordova Android Image

A docker image to build cordova apps for the Android platform and deploy them to your connected device.

## Build

Build the image using

`docker build -t cordova-builder .`

## Run

Start the container from your cordova app directory

`docker run -it -v $(pwd):/workspace -w /workspace --privileged -v /dev/bus/usb:/dev/bus/usb cordova-builder`

This will grant the docker container access to your USB devices.

Connect your Android device and enable Android Debugging in the developer settings.

Now, inside the container you can build the app and deploy it to your device.

```sh
cordova platform add android # if you haven't already.
cordova run android
```

You may have to run this twice, since cordova doesn't wait for the prompt on your device
to accept the debugging request.
