package com.Singing.DAO;

import java.util.List;

/**
 * Created by fowafolo on 15/5/18.
 */
public interface GeneralDAO<T> {

    /**
     * 通过String类型主键进行查询
     * @param id
     * @return
     */
    T queryById(String id);

    /**
     * 通过Int类型主键查询
     * @param id
     * @return
     */
    T queryByIntId(int id);

    /**
     * 查询所有T类型
     * @return
     */
    List<T> queryAll();

    /**
     * 插入T类型
     * @param t
     */
    void insert(T t);

    /**
     * 删除T类型实例
     * @param t
     */
    void delete(T t);

    /**
     * 更新T类型实例
     * @param t
     */
    void update(T t);
}
