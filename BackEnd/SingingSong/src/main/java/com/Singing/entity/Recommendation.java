package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 11:15
 */

@Table
@Entity
public class Recommendation {

    @Id
    private int r_id;
    private String track_id;
    private String track_name;
    private String artist_name;
    private String album_image;
    private String original_url;
    private String instra_url;
    private String lyrics;

    public int getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
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

    public String getArtist_name() {
        return artist_name;
    }

    public void setArtist_name(String artist_name) {
        this.artist_name = artist_name;
    }

    public String getAlbum_image() {
        return album_image;
    }

    public void setAlbum_image(String album_image) {
        this.album_image = album_image;
    }

    public String getOriginal_url() {
        return original_url;
    }

    public void setOriginal_url(String original_url) {
        this.original_url = original_url;
    }

    public String getInstra_url() {
        return instra_url;
    }

    public void setInstra_url(String instra_url) {
        this.instra_url = instra_url;
    }

    public String getLyrics() {
        return lyrics;
    }

    public void setLyrics(String lyrics) {
        this.lyrics = lyrics;
    }
}
