package com.Singing.DAO;

import com.Singing.entity.RankTable;
import com.Singing.entity.Tag;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/12
 * Time: 21:48
 */

@Repository
public class TagDAOImp extends GeneralDAOImp<Tag> implements TagDAO {
    public TagDAOImp() {
        super(Tag.class);
    }

    @Override
    public List<Tag> getTagsByName(String name) {
        String hql = "from Tag where tag_name like :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", name);
        List<Tag> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }
}
