package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Table
@Entity
public class Album {

    @Id
    private int key_id;
    private String album_id;
    private String album_image;
    private String album_name;

    public int getKey_id() {
        return key_id;
    }

    public void setKey_id(int key_id) {
        this.key_id = key_id;
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

    public String getAlbum_name() {
        return album_name;
    }

    public void setAlbum_name(String album_name) {
        this.album_name = album_name;
    }
}
