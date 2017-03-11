# Google Cloud SDK Docker Image

[![](https://images.microbadger.com/badges/image/wearegenki/google-cloud-sdk.svg)](https://microbadger.com/images/wearegenki/google-cloud-sdk "Get your own image badge on microbadger.com") [![GitHub Tag](https://img.shields.io/github/tag/wearegenki/docker-google-cloud-sdk.svg)](https://registry.hub.docker.com/u/wearegenki/google-cloud-sdk/)

Minimal Google Cloud SDK tools docker image running on an Alpine Linux base. Useful for automation on GCE or adhoc commands. Thanks to the Alpine Linux base, this image is only 166 MB uncompressed—compared to over 1 GB (_omg!_) for the [official image](https://hub.docker.com/r/google/cloud-sdk/). This image doesn't include any fancy extras which also helps keep it small.

## Usage

From a terminal simply run the image to enter a cli environment:

```
$ docker run -ti --rm wearegenki/google-cloud-sdk:latest
```

## Licence

ISC—feel free to use this source code however you like. See [LICENCE.md](https://github.com/WeAreGenki/docker-google-cloud-sdk/blob/master/LICENCE.md).

## Author

Proudly made by Max Milton &lt;<max@wearegenki.com>&gt;.

-----

&copy; We Are Genki
