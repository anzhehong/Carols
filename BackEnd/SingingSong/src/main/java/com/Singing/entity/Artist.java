package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Table
@Entity
public class Artist {

    @Id
    private int key_id;
    private String artist_id;
    private String artist_name;
    private String artist_image;
    private float artist_hotness;
    private String similar_artist1;
    private String similar_artist2;
    private String similar_artist3;
    private String similar_artist4;
    private String similar_artist5;

    public int getKey_id() {
        return key_id;
    }

    public void setKey_id(int key_id) {
        this.key_id = key_id;
    }

    public String getArtist_id() {
        return artist_id;
    }

    public void setArtist_id(String artist_id) {
        this.artist_id = artist_id;
    }

    public String getArtist_name() {
        return artist_name;
    }

    public void setArtist_name(String artist_name) {
        this.artist_name = artist_name;
    }

    public String getArtist_image() {
        return artist_image;
    }

    public void setArtist_image(String artist_image) {
        this.artist_image = artist_image;
    }

    public float getArtist_hotness() {
        return artist_hotness;
    }

    public void setArtist_hotness(float artist_hotness) {
        this.artist_hotness = artist_hotness;
    }

    public String getSimilar_artist1() {
        return similar_artist1;
    }

    public void setSimilar_artist1(String similar_artist1) {
        this.similar_artist1 = similar_artist1;
    }

    public String getSimilar_artist2() {
        return similar_artist2;
    }

    public void setSimilar_artist2(String similar_artist2) {
        this.similar_artist2 = similar_artist2;
    }

    public String getSimilar_artist3() {
        return similar_artist3;
    }

    public void setSimilar_artist3(String similar_artist3) {
        this.similar_artist3 = similar_artist3;
    }

    public String getSimilar_artist4() {
        return similar_artist4;
    }

    public void setSimilar_artist4(String similar_artist4) {
        this.similar_artist4 = similar_artist4;
    }

    public String getSimilar_artist5() {
        return similar_artist5;
    }

    public void setSimilar_artist5(String similar_artist5) {
        this.similar_artist5 = similar_artist5;
    }
}
