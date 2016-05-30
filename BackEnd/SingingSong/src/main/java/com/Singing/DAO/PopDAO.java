package com.Singing.DAO;

import com.Singing.entity.PopTable;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 17:03
 */
public interface PopDAO extends GeneralDAO<PopTable> {

    public List<PopTable> getPopRankList(int limit);
}
