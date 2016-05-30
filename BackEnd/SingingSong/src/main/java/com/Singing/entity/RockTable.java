package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 16:04
 */

@Table
@Entity
public class RockTable {

    @Id
    private int tag_id;
    private String tag_name;
    private float tag_hotness;
    private float tag_weight;
    private String track_id;
    private String artist_id;

    public int getTag_id() {
        return tag_id;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }

    public String getTag_name() {
        return tag_name;
    }

    public void setTag_name(String tag_name) {
        this.tag_name = tag_name;
    }

    public float getTag_hotness() {
        return tag_hotness;
    }

    public void setTag_hotness(float tag_hotness) {
        this.tag_hotness = tag_hotness;
    }

    public float getTag_weight() {
        return tag_weight;
    }

    public void setTag_weight(float tag_weight) {
        this.tag_weight = tag_weight;
    }

    public String getTrack_id() {
        return track_id;
    }

    public void setTrack_id(String track_id) {
        this.track_id = track_id;
    }

    public String getArtist_id() {
        return artist_id;
    }

    public void setArtist_id(String artist_id) {
        this.artist_id = artist_id;
    }
}