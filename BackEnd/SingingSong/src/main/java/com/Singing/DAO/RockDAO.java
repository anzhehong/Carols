package com.Singing.DAO;

import com.Singing.entity.RockTable;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 17:04
 */
public interface RockDAO extends GeneralDAO<RockTable> {

    public List<RockTable> getRockRankList(int limit);
}
