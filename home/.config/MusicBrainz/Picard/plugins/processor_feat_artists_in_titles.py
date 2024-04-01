PLUGIN_NAME = 'Feat. Artists in Titles'
PLUGIN_AUTHOR = 'Lukas Lalinsky, Michael Wiencek, Bryan Toth, JeromyNix (NobahdiAtoll), Ernest Shefer (shef-er)'
PLUGIN_DESCRIPTION = 'Move "feat." and "featuring" from artist names to album and track titles. Match is case insensitive.'
PLUGIN_VERSION = "0.6"
PLUGIN_API_VERSIONS = ["0.9.0", "0.10", "0.15", "0.16", "2.0", "2.1", "2.2", "2.3"]

from picard.metadata import register_album_metadata_processor, register_track_metadata_processor
import re

_feat_re = re.compile(r"([\s\S]+) f(ea)?t(\.|uring)? ([\s\S]+)", re.IGNORECASE)


def move_album_feat_artists(tagger, metadata, release):
    match = _feat_re.match(metadata["albumartist"])
    if match:
        metadata["albumartist"] = match.group(1).strip()
        metadata["album"] += " (feat. %s)" % match.group(4).strip()
    match = _feat_re.match(metadata["albumartistsort"])
    if match:
        metadata["albumartistsort"] = match.group(1).strip()


def move_track_feat_artists(tagger, metadata, track, release):
    match = _feat_re.match(metadata["artist"])
    if match:
        metadata["artist"] = match.group(1).strip()
        metadata["title"] += " (feat. %s)" % match.group(4).strip()
    match = _feat_re.match(metadata["artistsort"])
    if match:
        metadata["artistsort"] = match.group(1).strip()

register_album_metadata_processor(move_album_feat_artists)
register_track_metadata_processor(move_track_feat_artists)
