package com.Singing.service;

import com.Singing.DAO.ArtistDAO;
import com.Singing.DAO.TrackDAO;
import com.Singing.entity.Artist;
import com.Singing.entity.Song;
import com.Singing.entity.Track;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public class MainServiceImp implements MainService {


    @Autowired
    private ArtistDAO artistDAO;
    private TrackDAO trackDAO;

    @Override
    public List<Song> queryByArtist(String star) {
        List<Artist> artists = artistDAO.queryByArtistName(star);
        if (artists == null)
        return null;
        else
        {
            ArrayList<Song> songs = new ArrayList<>();

            for (int i = 0; i < artists.size(); i++)
            {
               List<Track> tracks = trackDAO.queryByStar(artists.get(i).getArtist_id());
                //TODO: if null continue?
                for (int j = 0; j< tracks.size(); j++)
                {
                    Song song = new Song();
                    song.setArtistName(star);
//                    song.setSongName(tracks.get(i).getTrack_name());
//                    song.set(tracks.get(i).g);
                }
            }

            return songs;
        }
    }

    @Override
    public List<Song> queryByAlbum(String album) {
        return null;
    }

    @Override
    public List<Song> queryByName(String name) {
        return null;
    }
}
