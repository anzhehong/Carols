package com.Singing.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Table
@Entity
public class History {

    @Id
    private int history_id;
    private String user_id;
    private String track_id;
    private String plays;

    public int getHistory_id() {
        return history_id;
    }

    public void setHistory_id(int history_id) {
        this.history_id = history_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getTrack_id() {
        return track_id;
    }

    public void setTrack_id(String track_id) {
        this.track_id = track_id;
    }

    public String getPlays() {
        return plays;
    }

    public void setPlays(String plays) {
        this.plays = plays;
    }
}
