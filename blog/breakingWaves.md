<!-- Breaking Waves -->
<!-- Structure: for clarity start off with WAV; then move to FLAC at the end -->

At the KB we have a large collection of offline optical media. Most of these are CD-ROMs, but we also have a sizeable proportion of audio CDs. We're currently in the process of designing a workflow for stabilising the contents of these materials using disk imaging. For audio CDs this involves 'ripping' the tracks to audio files. Since the workflow will be automated to a high degree, basic quality checks on the created audio files are needed. In particular, we want to be sure that the created audio files are complete, as it is possible that some hardware failure during the ripping process could result in a truncated or otherwise incomplete file.

To get a better idea of what software tool(s) are best suitable for this task, I created a small dataset of audio files which I deliberately damaged. I subsequently ran each of these files through a set of candidate tools, and then looked which tools were able to detect the faulty files. The focus of this blog post is on the [*WAVE*](http://fileformats.archiveteam.org/wiki/WAVE) format; in the final section I also present some results for [*FLAC*](http://fileformats.archiveteam.org/wiki/FLAC) (at the moment we haven't decided on which format to use yet).

<!--more-->

## *WAVE* dataset

For the *WAVE* dataset I started out with a [small, intact *WAVE* file](./data/frogs-01.wav). Using a Hex editor I then made the following derivatives of this file:

* [frogs-01-last-byte-missing.wav](./data/frogs-01-last-byte-missing.wav) - one byte is missing at the end of the file
* [frogs-01-last-2032-bytes-missing.wav](./data/frogs-01-last-2032-bytes-missing.wav) - chunk of  2032 bytes are missing at the end of the file
* [frogs-01-byte-missing-at-offset-811537.wav](./data/frogs-01-byte-missing-at-offset-811537.wav) - one byte is missing at offset 811537

## Candidate tools, *WAVE*

The candidate tools I used to analyse the *WAVE* files are:  

* [**jhove**](http://jhove.openpreservation.org/) includes a [*WAVE* validation module](http://jhove.openpreservation.org/modules/wave/), which makes it an obvious choice. The tested version is  1.14.6, 2016-05-12.
* [**shntool**](http://www.etree.org/shnutils/shntool/) is a "multi-purpose WAVE data processing and reporting utility". It was first released in 2000. The tested version 3.0.7.
* [**ffprobe**](https://ffmpeg.org/ffprobe.html) is a feature extraction tool that is part of [ffmpeg](https://ffmpeg.org/). The tested version 3.3.2.
* [**mediainfo**](https://mediaarea.net/en/MediaInfo) is another widely-used feature extraction tool for audiovisual files. The tested version is v0.7.81.

Note that of the above tools, only *jhove* and *shntool* are designed to detect problems in *WAVE* files. Both *ffprobe* and *mediainfo* are primarily tools for extracting technical information, and they were *not* designed to detect defective files! I included these tools here mainly because they are widely used, and I was curious whether they would throw up anything interesting in case of defective files.

## Results


 


## Data

* [flac](https://xiph.org/flac/), version 1.3.0

## Conclusion

## Data

All example files and scripts that were used in these experiments are available here:

<https://github.com/bitsgalore/detectDamagedAudio>
