package com.Singing.DAO;

import com.Singing.entity.Tag;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/12
 * Time: 21:47
 */
public interface TagDAO extends GeneralDAO<Tag> {
    public List<Tag> getTagsByName(String name);
}
