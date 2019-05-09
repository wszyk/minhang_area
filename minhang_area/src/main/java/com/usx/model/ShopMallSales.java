package com.usx.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="shop_mall_sales")
public class ShopMallSales {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	@Column
	private Integer shop_mall_id;
	@Column
	private Date sale_time;
	@Column
	private double sales;
	@Column
	private Date create_time;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getShop_mall_id() {
		return shop_mall_id;
	}

	public void setShop_mall_id(Integer shop_mall_id) {
		this.shop_mall_id = shop_mall_id;
	}

	public Date getSale_time() {
		return sale_time;
	}

	public void setSale_time(Date sale_time) {
		this.sale_time = sale_time;
	}

	public double getSales() {
		return sales;
	}

	public void setSales(double sales) {
		this.sales = sales;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}
