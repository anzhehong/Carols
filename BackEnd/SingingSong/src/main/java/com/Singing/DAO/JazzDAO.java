package com.Singing.DAO;

import com.Singing.entity.JazzTable;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 16:05
 */
public interface JazzDAO extends GeneralDAO<JazzTable> {

    public List<JazzTable> getJazzRankList(int limit);

    public List<JazzTable> getByIds(List<String> ids);
}
