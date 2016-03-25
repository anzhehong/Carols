package com.Singing.service;

import com.Singing.entity.Music;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/3/25
 * Time: 11:35
 */
public interface MusicService {

    /**
     * 列出所有音乐
     * @return
     */
    public List<Music> getAllMusics();
}
