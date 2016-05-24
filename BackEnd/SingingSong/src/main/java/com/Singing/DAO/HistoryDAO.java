package com.Singing.DAO;

import com.Singing.entity.History;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 13:26
 */
public interface HistoryDAO extends GeneralDAO<History> {

    public List<History> getHistoriesByUserId(String userId);
}
