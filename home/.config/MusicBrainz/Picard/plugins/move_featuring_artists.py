PLUGIN_NAME = u'Move featuring artists'
PLUGIN_AUTHOR = u'Ernest Shefer (shef-er)'
PLUGIN_DESCRIPTION = u'''Context action to move all featuring artists that mentioned after specific words'''
PLUGIN_VERSION = '0.3.1'
PLUGIN_API_VERSIONS = ["2.3", "2.4", "2.5", "2.6", "2.7", "2.8", "2.9", "2.10", "2.11"]
PLUGIN_LICENSE = "GPL-3.0"
PLUGIN_LICENSE_URL = "http://www.gnu.org/licenses/gpl-3.0.txt"

TAG_ALBUMARTIST = 'albumartist'
TAG_ALBUMARTISTSORT = 'albumartistsort'
TAG_ALBUM = 'album'

TAG_ARTIST = 'artist'
TAG_ARTISTSORT = 'artistsort'
TAG_TITLE = 'title'

from picard.album import Album
from picard.metadata import register_album_metadata_processor, register_track_metadata_processor
from picard.ui.itemviews import BaseAction, register_album_action
import re

def move_featuring_artists_to_title(metadata, artist_tag, artist_sort_tag, title_tag):
    pattern = re.compile(r"([\s\S]+) f(ea)?t(\.|uring)? ([\s\S]+)", re.IGNORECASE)
    if match := pattern.match(metadata.get(artist_tag)):
        metadata.set(
            artist_tag,
            match.group(1).strip()
        )
        metadata.set(
            title_tag,
            metadata.get(title_tag) + " (feat. %s)" % match.group(4).strip()
        )
    if match := pattern.match(metadata.get(artist_sort_tag)):
        metadata.set(
            artist_sort_tag,
            match.group(1).strip()
        )

def move_album_featuring_artists_processor(tagger, metadata, release):
    move_featuring_artists_to_title(metadata, TAG_ALBUMARTIST, TAG_ALBUMARTISTSORT, TAG_ALBUM)

def move_track_featuring_artists_processor(tagger, metadata, track, release):
    move_featuring_artists_to_title(metadata, TAG_ARTIST, TAG_ARTISTSORT, TAG_TITLE)

register_album_metadata_processor(move_album_featuring_artists_processor)
register_track_metadata_processor(move_track_featuring_artists_processor)


def move_extra_artists_to_title(metadata, artist_tag, artist_sort_tag, title_tag):
    pattern = re.compile(r"([\s\S]+) (&|\+|×) ([\s\S]+)", re.IGNORECASE)
    if match := pattern.match(metadata.get(artist_tag)):
        metadata.set(
            artist_tag,
            match.group(1).strip()
        )
        metadata.set(
            title_tag,
            metadata.get(title_tag) + " (feat. %s)" % match.group(3).strip()
        )
    if match := pattern.match(metadata.get(artist_sort_tag)):
        metadata.set(
            artist_sort_tag,
            match.group(1).strip()
        )

class MoveExtraArtists(BaseAction):
    NAME = 'Move extra artists'

    def callback(self, objs):

        for album in objs:
            if isinstance(album, Album):
                move_extra_artists_to_title(album.metadata, TAG_ALBUMARTIST, TAG_ALBUMARTISTSORT, TAG_ALBUM)

                for track in album.tracks:
                    # move_extra_artists_to_title(track.metadata, TAG_ALBUMARTIST, TAG_ALBUMARTISTSORT, TAG_ALBUM)
                    move_extra_artists_to_title(track.metadata, TAG_ARTIST, TAG_ARTISTSORT, TAG_TITLE)

                    for files in track.linked_files:
                        track.update_file_metadata(files)

                album.update()

register_album_action(MoveExtraArtists())