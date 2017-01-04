
## Purpose of this repo

Determine what is the best software tool for detecting damaged/incomplete/truncated WAVE and FLAC audio files.

## Data

### WAVE files

* [frogs-01.wav](./data/frogs-01.wav) - intact WAV file
* [frogs-01-last-byte-missing.wav](./data/frogs-01-last-byte-missing.wav) - last byte is missing
* [frogs-01-last-2032-bytes-missing.wav](./data/frogs-01-last-2032-bytes-missing.wav) - last 2032 bytes are missing
* [frogs-01-byte-missing-at-offset-811537.wav](./data/frogs-01-byte-missing-at-offset-811537.wav) - byte missing at offset 811537

### FLAC files

* [frogs-01.flac](./data/frogs-01.flac) - intact FLAC file
* [frogs-01-last-byte-missing.flac](./data/frogs-01-last-byte-missing.flac) - last byte is missing
* [frogs-01-last-1000-bytes-missing.flac](./data/frogs-01-last-1000-bytes-missing.flac) - last 1000 bytes are missing
* [frogs-01-byte-missing-at-offset-651202.flac](./data/frogs-01-byte-missing-at-offset-651202.flac) - byte missing at offset 651202

## Tools

* [jhove](http://jhove.openpreservation.org/), version 1.14.6, 2016-05-12
* [shntool](http://www.etree.org/shnutils/shntool/), version 3.0.7
* [ffmpeg](https://ffmpeg.org/), version 3.2.2
* [mediainfo](https://mediaarea.net/en/MediaInfo), version v0.7.81
* [flac](https://xiph.org/flac/), version 1.3.0


## License

All data and scripts in this repo released under the [CC-BY](https://creativecommons.org/licenses/by/4.0/) license.


