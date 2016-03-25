package com.Singing.DAO;

import com.Singing.entity.Music;
import org.springframework.stereotype.Repository;

/**
 * Created by fowafolo
 * Date: 16/3/25
 * Time: 11:32
 */

@Repository
public class MusicDAOImp extends GeneralDAOImp<Music> implements MusicDAO {

    public MusicDAOImp() {
        super(Music.class);
    }
}
