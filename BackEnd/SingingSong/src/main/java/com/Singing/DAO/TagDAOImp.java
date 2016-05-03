package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Song;
import com.Singing.entity.Tag;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Repository
public class TagDAOImp extends GeneralDAOImp<Tag> implements TagDAO{
    public TagDAOImp() {
        super(Tag.class);
    }

    @Override
    public List<Song> queryAllSongs() {
        return null;
    }

    @Override
    public List<Song> queryJazzSongs() {
        return null;
    }

    @Override
    public List<Song> queryPopSongs() {
        return null;
    }

    @Override
    public List<Song> queryRBSongs() {
        return null;
    }
}
