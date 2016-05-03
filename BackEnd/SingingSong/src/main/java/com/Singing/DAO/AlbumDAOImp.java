package com.Singing.DAO;

import com.Singing.entity.Album;
import com.Singing.entity.Artist;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Repository
public class AlbumDAOImp extends GeneralDAOImp<Album> implements AlbumDAO{
    public AlbumDAOImp() {
        super(Album.class);
    }
}
