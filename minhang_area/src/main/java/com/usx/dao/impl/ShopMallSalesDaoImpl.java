package com.usx.dao.impl;

import com.usx.dao.ShopMallSalesDao;
import com.usx.model.ShopMallSales;
import com.usx.util.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopMallSalesDaoImpl implements ShopMallSalesDao {

    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void saveData(ShopMallSales shopMallSales) {
        hibernateUtil.create(shopMallSales);
    }
}
