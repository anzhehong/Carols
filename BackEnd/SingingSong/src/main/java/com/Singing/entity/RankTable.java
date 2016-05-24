package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by fowafolo
 * Date: 16/5/10
 * Time: 23:39
 */

@Table
@Entity
public class RankTable {

    @Id
    private int Rank;
    private String track_id;
    private String track_name;
    private float track_hotness;
    private String artist_name;
    private String album_id;
    private String album_image;
    private String oringinal_url;
    private String instra_url;
    private String lyrics;
    private String tag_name;

    public RankTable(String track_id, String track_name, String artist_name, String album_image,
                     String oringinal_url, String instra_url, String lyrics) {
        this.track_id = track_id;
        this.track_name = track_name;
        this.artist_name = artist_name;
        this.album_image = album_image;
        this.oringinal_url = oringinal_url;
        this.instra_url = instra_url;
        this.lyrics = lyrics;
    }

    public RankTable() {
    }

    public int getRank() {
        return Rank;
    }

    public void setRank(int rank) {
        Rank = rank;
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

    public float getTrack_hotness() {
        return track_hotness;
    }

    public void setTrack_hotness(float track_hotness) {
        this.track_hotness = track_hotness;
    }

    public String getArtist_name() {
        return artist_name;
    }

    public void setArtist_name(String artist_name) {
        this.artist_name = artist_name;
    }

    public String getAlbum_id() {
        return album_id;
    }

    public void setAlbum_id(String album_id) {
        this.album_id = album_id;
    }

    public String getAlbum_image() {
        return album_image;
    }

    public void setAlbum_image(String album_image) {
        this.album_image = album_image;
    }

    public String getOringinal_url() {
        return oringinal_url;
    }

    public void setOringinal_url(String oringinal_url) {
        this.oringinal_url = oringinal_url;
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

    public String getTag_name() {
        return tag_name;
    }

    public void setTag_name(String tag_name) {
        this.tag_name = tag_name;
    }
}
