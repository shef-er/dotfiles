PLUGIN_NAME = u'Move featuring artists to track titles'
PLUGIN_AUTHOR = u'Ernest Shefer (shef-er)'
PLUGIN_DESCRIPTION = u'''Context action to move all featuring artists that mentioned after words: feat., &, ×, +'''
PLUGIN_VERSION = '0.1'
PLUGIN_API_VERSIONS = ["2.0", "2.1", "2.2", "2.3"]
PLUGIN_LICENSE = "GPL-3.0"
PLUGIN_LICENSE_URL = "http://www.gnu.org/licenses/gpl-3.0.txt"

from picard.album import Album
from picard.ui.itemviews import BaseAction, register_album_action
import re

class MoveFeaturingArtistsToTrackTitles(BaseAction):
    NAME = 'Move featuring artists to track titles'

    def callback(self, objs):
        _feat_re = re.compile(r"([\s\S]+) (feat\.|&|\+|×) ([\s\S]+)", re.IGNORECASE)

        for album in objs:
            if isinstance(album, Album):
                metadata = album.metadata

                match = _feat_re.match(metadata["albumartist"])
                if match:
                    # metadata["albumartist"] = match.group(1)
                    album.metadata.set("albumartist", match.group(1).strip())
                    # metadata["album"] += " (feat.%s)" % match.group(3)
                    album.metadata.set("album", album.metadata.get("album") + " (feat. %s)" % match.group(3).strip())
                match = _feat_re.match(metadata["albumartistsort"])
                if match:
                    # metadata["albumartistsort"] = match.group(1)
                    album.metadata.set("albumartistsort", match.group(1).strip())

                for track in album.tracks:
                    metadata = track.metadata

                    match = _feat_re.match(metadata["albumartist"])
                    if match:
                        metadata["albumartist"] = match.group(1).strip()
                        metadata["album"] += " (feat. %s)" % match.group(3).strip()
                    match = _feat_re.match(metadata["albumartistsort"])
                    if match:
                        metadata["albumartistsort"] = match.group(1).strip()

                    match = _feat_re.match(metadata["artist"])
                    if match:
                        metadata["artist"] = match.group(1).strip()
                        metadata["title"] += " (feat. %s)" % match.group(3).strip()

                    match = _feat_re.match(metadata["artistsort"])
                    if match:
                        metadata["artistsort"] = match.group(1).strip()

                    for files in track.linked_files:
                        track.update_file_metadata(files)

                album.update()


register_album_action(MoveFeaturingArtistsToTrackTitles())