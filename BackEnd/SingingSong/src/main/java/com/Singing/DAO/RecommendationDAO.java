package com.Singing.DAO;

import com.Singing.entity.Recommendation;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 11:17
 */
public interface RecommendationDAO extends GeneralDAO<Recommendation> {

    public List<Recommendation> getByTrackId(String id);
    public Recommendation getByTrackOneId(String id);

    public List<Recommendation> getByIds(List<String> ids);
}
