<!-- Breaking Waves -->
<!-- Structure: for clarity start off with WAV; then move to FLAC at the end -->

At the KB we have a large collection of offline optical media. Most of these are CD-ROMs, but we also have a sizeable proportion of audio CDs. We're currently in the process of designing a workflow for stabilising the contents of these materials using disk imaging. For audio CDs this involves 'ripping' the tracks to audio files. Since the workflow will be automated to a high degree, basic quality checks on the created audio files are needed. In particular, we want to be sure that the created audio files are complete, as it is possible that some hardware failure during the ripping process could result in a truncated or otherwise incomplete file.

To get a better idea of what software tool(s) are best suitable for this task, I created a small dataset of audio files which I deliberately damaged. I subsequently ran each of these files through a set of candidate tools, and then looked which tools were able to detect the faulty files. The focus of this blog post is on the [*WAVE*](http://fileformats.archiveteam.org/wiki/WAVE) format; in the final section I also present some results for [*FLAC*](http://fileformats.archiveteam.org/wiki/FLAC) (at the moment we haven't decided on which format to use yet).

<!--more-->

https://github.com/bitsgalore/detectDamagedAudio/blob/master/data/frogs-01.wav

## *WAVE* dataset

For the *WAVE* dataset I started out with a [small, intact *WAVE* file](https://github.com/bitsgalore/detectDamagedAudio/blob/master/data/frogs-01.wav). Using a Hex editor I then made the following derivatives of this file:

* [frogs-01-last-byte-missing.wav](https://github.com/bitsgalore/detectDamagedAudio/blob/master/data/frogs-01-last-byte-missing.wav) - one byte is missing at the end of the file
* [frogs-01-last-2032-bytes-missing.wav](https://github.com/bitsgalore/detectDamagedAudio/blob/master/data/frogs-01-last-2032-bytes-missing.wav) - chunk of  2032 bytes are missing at the end of the file
* [frogs-01-byte-missing-at-offset-811537.wav](https://github.com/bitsgalore/detectDamagedAudio/blob/master/data/frogs-01-byte-missing-at-offset-811537.wav) - one byte is missing at offset 811537

## Candidate tools, *WAVE*

The candidate tools I used to analyse the *WAVE* files are:  

* [**jhove**](http://jhove.openpreservation.org/) includes a [*WAVE* validation module](http://jhove.openpreservation.org/modules/wave/), which makes it an obvious choice. The tested version is  1.14.6, 2016-05-12.
* [**shntool**](http://www.etree.org/shnutils/shntool/) is a "multi-purpose WAVE data processing and reporting utility". It was first released in 2000. The tested version is 3.0.7.
* [**ffmpeg**](https://ffmpeg.org/) is a popular conversion tool for audio and video formats. The tested version is 3.2.2.
* [**mediainfo**](https://mediaarea.net/en/MediaInfo) is a widely-used feature extraction tool for audiovisual files. The tested version is v0.7.81.

Note that of the above tools, only *jhove* and *shntool* are designed to detect problems in *WAVE* files. Both *ffmpeg* and *mediainfo* were primarily designed for other purposes (format conversion and technical metadata extraction), and they were *not* designed to detect defective files! I included these tools here mainly because they are widely used, and I was curious whether they would throw up anything interesting in case of defective files. Also, [this thread on *superuser.com*](http://superuser.com/a/100290/681049) recommends *ffmpeg* for checking the integrity of video files.  

I ran the tools with the following command-line arguments (replacing "foo.wav" with the actual file name):

### Jhove
    jhove -m WAVE-hul foo.wav
### Shntool
    shntool info foo.wav
### Ffmpeg
    ffmpeg -v error -i foo.wav -f null -
### Mediainfo
    mediainfo foo.wav

I automated this using a simple [shell script](https://github.com/bitsgalore/detectDamagedAudio/blob/master/runtools.sh) that runs each tool on all files, and then writes the output to a set of text files.

## Results, *WAVE*

The full output results of each tool can be found [here](https://github.com/bitsgalore/detectDamagedAudio/tree/master/output). 

### Jhove

The 'Status' field in Jhove's output summarises the validation outcome. Here are the results for each file: 

|File|Result|
|:--|:--|
|frogs-01.wav|Status: Well-Formed and valid|
|frogs-01-last-byte-missing.wav|Status: Well-Formed and valid|
|frogs-01-last-2032-bytes-missing.wav|Status: Well-Formed and valid|
|frogs-01-byte-missing-at-offset-811537.wav|Status: Well-Formed and valid|

So, Jhove was unable to detect *any* of the damaged files at all! 

### Shntool

Shntool checks a *WAVE* on six criteria, which are listed in its output under 'Possible problems': 

    Possible problems:
      File contains ID3v2 tag:    no
      Data chunk block-aligned:   yes
      Inconsistent header:        no
      File probably truncated:    no
      Junk appended to file:      no
      Odd data size has pad byte: n/a

The thing to watch here is the 'File probably truncated' item: 

|File|Result|
|:--|:--|
|frogs-01.wav|File probably truncated:    no|
|frogs-01-last-byte-missing.wav|File probably truncated:    yes (missing 1 byte)|
|frogs-01-last-2032-bytes-missing.wav|File probably truncated:    yes (missing 2032 bytes|
|frogs-01-byte-missing-at-offset-811537.wav|File probably truncated:    yes (missing 1 byte)|

So, Shntool was able to detect all damaged files.

### Ffmpeg

For our Ffmpeg call we monitor any errors that are sent to the standard error stream. The results:

|File|result|
|:--|:--|
|frogs-01.wav|-|
|frogs-01-last-byte-missing.wav|[pcm_s16le @ 0x3545380] Invalid PCM packet, data has size 3 but at least a size of 4 was expected<br>Error while decoding stream #0:0: Invalid data found when processing input|
|frogs-01-last-2032-bytes-missing.wav|-|
|frogs-01-byte-missing-at-offset-811537.wav|[pcm_s16le @ 0x2768380] Invalid PCM packet, data has size 3 but at least a size of 4 was expected<br>Error while decoding stream #0:0: Invalid data found when processing input|

Interestingly, ffmpeg reports an error for both files that have 1 byte missing, but it doesn't for the file that has 2023 bytes missing. This suggests that Ffmpeg is *not* suitable for detecting broken *WAVE* files.

### Mediainfo

Mediainfo didn't report errors or warnings for any of these files. This is not surprising, but it does confirm that Mediainfo cannot be used for detecting broken *WAVE* files.  



## Data

* [flac](https://xiph.org/flac/), version 1.3.0

    flac -t foo.flac

## Conclusion

## Data

All example files and scripts that were used in these experiments are available here:

<https://github.com/bitsgalore/detectDamagedAudio>
