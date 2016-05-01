package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Table
@Entity
public class Track {

    @Id
    private int keyid;

    private String track_id;
    private String track_name;
    private float track_hotness;
    private String year;
    private String artist_id;
    private String album_id;
    private String original_url;
    private String instra_url;

    public int getKeyid() {
        return keyid;
    }

    public void setKeyid(int keyid) {
        this.keyid = keyid;
    }

    public String getTrack_id() {
        return track_id;
    }

    public void setTrack_id(String track_id) {
        this.track_id = track_id;
    }

    public String getTrack_name() {
        return track_name;
    }

    public void setTrack_name(String track_name) {
        this.track_name = track_name;
    }

    public double getTrack_hotness() {
        return track_hotness;
    }

    public void setTrack_hotness(float track_hotness) {
        this.track_hotness = track_hotness;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getArtist_id() {
        return artist_id;
    }

    public void setArtist_id(String artist_id) {
        this.artist_id = artist_id;
    }

    public String getAlbum_id() {
        return album_id;
    }

    public void setAlbum_id(String album_id) {
        this.album_id = album_id;
    }

    public String getOriginal_url() {
        return original_url;
    }

    public void setOriginal_url(String original_url) {
        this.original_url = original_url;
    }

    public String getInstral_url() {
        return instra_url;
    }

    public void setInstral_url(String instral_url) {
        this.instra_url = instral_url;
    }


}
