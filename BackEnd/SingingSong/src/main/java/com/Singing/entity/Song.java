package com.Singing.entity;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public class Song {
    private String songName;
    private String artistName;
    private String album;
    private String pictureURL;
    private String trackURL;
    private String lyrics;
    private List<String> tags;

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

    public String  getTrackSteam() {
        return trackURL;
    }

    public void setTrackSteam(String  trackSteam) {
        this.trackURL = trackSteam;
    }

    public String getLyrics() {
        return lyrics;
    }

    public void setLyrics(String lyrics) {
        this.lyrics = lyrics;
    }
    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public String getTrackURL() {
        return trackURL;
    }

    public void setTrackURL(String trackURL) {
        this.trackURL = trackURL;
    }


}
