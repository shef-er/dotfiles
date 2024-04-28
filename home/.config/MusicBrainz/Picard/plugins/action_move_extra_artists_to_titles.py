PLUGIN_NAME = u'Move featuring artists to track and album titles'
PLUGIN_AUTHOR = u'Ernest Shefer (shef-er)'
PLUGIN_DESCRIPTION = u'''Context action to move all featuring artists that mentioned after words: feat., &, ×, +'''
PLUGIN_VERSION = '0.2.1'
PLUGIN_API_VERSIONS = ["2.0", "2.1", "2.2", "2.3", "2.4", "2.5", "2.6", "2.7", "2.8", "2.9", "2.10", "2.11"]
PLUGIN_LICENSE = "GPL-3.0"
PLUGIN_LICENSE_URL = "http://www.gnu.org/licenses/gpl-3.0.txt"

TAG_ALBUMARTIST = 'albumartist'
TAG_ALBUMARTISTSORT = 'albumartistsort'
TAG_ALBUM = 'album'

TAG_ARTIST = 'artist'
TAG_ARTISTSORT = 'artistsort'
TAG_TITLE = 'title'

from picard.album import Album
from picard.ui.itemviews import BaseAction, register_album_action
import re

def move_featuring_artists_to_title(metadata, artist_tag, title_tag):
    pattern = re.compile(r"([\s\S]+) (feat\.|&|\+|×) ([\s\S]+)", re.IGNORECASE)
    if match := pattern.match(metadata.get(artist_tag)):
        metadata.set(
            artist_tag,
            match.group(1).strip()
        )
        metadata.set(
            title_tag,
            metadata.get(title_tag) + " (feat. %s)" % match.group(3).strip()
        )

def strip_featuring_artists_from_sort(metadata, artist_sort_tag):
    pattern = re.compile(r"([\s\S]+) (feat\.|&|\+|×) ([\s\S]+)", re.IGNORECASE)
    if match := pattern.match(metadata.get(artist_sort_tag)):
        metadata.set(
            artist_sort_tag,
            match.group(1).strip()
        )

class MoveFeaturingArtistsToTitles(BaseAction):
    NAME = 'Move featuring artists to track and album titles'

    def callback(self, objs):

        for album in objs:
            if isinstance(album, Album):
                move_featuring_artists_to_title(album.metadata, TAG_ALBUMARTIST, TAG_ALBUM)
                strip_featuring_artists_from_sort(album.metadata, TAG_ALBUMARTISTSORT)

                for track in album.tracks:
                    # move_featuring_artists_to_title(track.metadata, TAG_ALBUMARTIST, TAG_ALBUM)
                    # strip_featuring_artists_from_sort(track.metadata, TAG_ALBUMARTISTSORT)

                    move_featuring_artists_to_title(track.metadata, TAG_ARTIST, TAG_TITLE)
                    strip_featuring_artists_from_sort(track.metadata, TAG_ARTISTSORT)

                    for files in track.linked_files:
                        track.update_file_metadata(files)

                album.update()

register_album_action(MoveFeaturingArtistsToTitles())