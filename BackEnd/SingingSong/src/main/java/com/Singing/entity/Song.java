package com.Singing.entity;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public class Song {
    private String songName;
    private String artistName;
    private String album;
    private String pictureURL;
    private Byte trackSteam;
    private Byte lyrics;

    public String getSongName() {
        return songName;
    }

    public void setSongName(String songName) {
        this.songName = songName;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }

    public String getAlbum() {
        return album;
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public String getPictureURL() {
        return pictureURL;
    }

    public void setPictureURL(String pictureURL) {
        this.pictureURL = pictureURL;
    }

    public Byte getTrackSteam() {
        return trackSteam;
    }

    public void setTrackSteam(Byte trackSteam) {
        this.trackSteam = trackSteam;
    }

    public Byte getLyrics() {
        return lyrics;
    }

    public void setLyrics(Byte lyrics) {
        this.lyrics = lyrics;
    }


}
