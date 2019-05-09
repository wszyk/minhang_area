package com.usx.dao.impl;

import com.usx.dao.ShopMallDao;
import com.usx.model.ShopMall;
import com.usx.util.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopMallDaoImpl implements ShopMallDao {

    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void saveData(ShopMall shopMall) {
        hibernateUtil.create(shopMall);
    }
}
