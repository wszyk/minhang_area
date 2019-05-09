package com.usx.dao.impl;

import com.usx.dao.IndustryDao;
import com.usx.model.Industry;
import com.usx.util.HibernateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class IndustryDaoImpl implements IndustryDao {
    @Autowired
    private HibernateUtil hibernateUtil;

    @Override
    public void saveData(Industry industry) {
        hibernateUtil.create(industry);
    }
}
