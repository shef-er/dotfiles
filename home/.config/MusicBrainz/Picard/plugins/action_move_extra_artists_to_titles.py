PLUGIN_NAME = u'Move featuring artists to track titles'
PLUGIN_AUTHOR = u'Ernest Shefer (shef-er)'
PLUGIN_DESCRIPTION = u'''Context action to move all featuring artists that mentioned after words: feat., &, ×, +'''
PLUGIN_VERSION = '0.1'
PLUGIN_API_VERSIONS = ["2.0", "2.1", "2.2", "2.3"]
PLUGIN_LICENSE = "GPL-3.0"
PLUGIN_LICENSE_URL = "http://www.gnu.org/licenses/gpl-3.0.txt"

TAG_ARTIST = 'artist'
TAG_ARTISTSORT = 'artistsort'

TAG_ALBUMARTIST = 'albumartist'
TAG_ALBUMARTISTSORT = 'albumartistsort'

TAG_ALBUM = 'album'
TAG_TITLE = 'title'

from picard.album import Album
from picard.ui.itemviews import BaseAction, register_album_action
import re

class MoveFeaturingArtistsToTrackTitles(BaseAction):
    NAME = 'Move featuring artists to track titles'

    def callback(self, objs):
        _feat_re = re.compile(r"([\s\S]+) (feat\.|&|\+|×) ([\s\S]+)", re.IGNORECASE)

        for album in objs:
            if isinstance(album, Album):
                match = _feat_re.match(album.metadata.get(TAG_ALBUMARTIST))
                if match:
                    album.metadata.set(
                        TAG_ALBUMARTIST,
                        match.group(1).strip()
                    )
                    album.metadata.set(
                        TAG_ALBUM,
                        album.metadata.get(TAG_ALBUM) + " (feat. %s)" % match.group(3).strip()
                    )
                match = _feat_re.match(album.metadata.get(TAG_ALBUMARTISTSORT))
                if match:
                    album.metadata.set(
                        TAG_ALBUMARTISTSORT,
                        match.group(1).strip()
                    )

                for track in album.tracks:
                    match = _feat_re.match(track.metadata.get(TAG_ALBUMARTIST))
                    if match:
                        track.metadata.set(
                            TAG_ALBUMARTIST,
                            match.group(1).strip()
                        )
                        track.metadata.set(
                            TAG_ALBUM,
                            track.metadata.get(TAG_ALBUM) + " (feat. %s)" % match.group(3).strip()
                        )

                    match = _feat_re.match(track.metadata.get(TAG_ALBUMARTISTSORT))
                    if match:
                        track.metadata.set(
                            TAG_ALBUMARTISTSORT,
                            match.group(1).strip()
                        )

                    match = _feat_re.match(track.metadata.get(TAG_ARTIST))
                    if match:
                        track.metadata.set(
                            TAG_ARTIST,
                            match.group(1).strip()
                        )
                        track.metadata.set(
                            TAG_TITLE,
                            track.metadata.get(TAG_TITLE) + " (feat. %s)" % match.group(3).strip()
                        )

                    match = _feat_re.match(track.metadata.get(TAG_ARTISTSORT))
                    if match:
                        track.metadata.set(
                            TAG_ARTISTSORT,
                            match.group(1).strip()
                        )

                    for files in track.linked_files:
                        track.update_file_metadata(files)

                album.update()


register_album_action(MoveFeaturingArtistsToTrackTitles())