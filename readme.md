
## Purpose of this repo

Determine what is the best software tool for detecting damaged/incomplete/truncate WAVE audio files.

## Data

* [frogs-01.wav](./data/frogs-01.wav) - intact WAV file
* [frogs-01-last-byte-missing.wav](./data/frogs-01-last-byte-missing.wav) - last byte is missing
* [frogs-01-byte-missing-at-offset-811537.wav](./data/frogs-01-byte-missing-at-offset-811537.wav) - byte missing at byte offset 811537

## Tools

* [jhove](http://jhove.openpreservation.org/), version 1.14.6, 2016-05-12
* [shntool](http://www.etree.org/shnutils/shntool/), version 3.0.7
* [ffprobe](https://ffmpeg.org/ffprobe.html) (part of [ffmpeg](https://ffmpeg.org/), version 3.3.2
* [mediainfo](https://mediaarea.net/en/MediaInfo), version v0.7.81

Note: *ffprobe* and *mediainfo* are primarily tools for extracting technical information. They are not designed to detect defective files.

## Tests

    jhove foo.wav
    jhove -m WAVE-hul foo.wav
    shntool info foo.wav > shntool.txt
    ffprobe foo.wav -show_format -show_streams > ffprobe.txt
 