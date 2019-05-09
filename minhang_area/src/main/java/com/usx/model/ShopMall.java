package com.usx.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="shop_mall")
public class ShopMall {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	@Column
	private String name;
	@Column
	private String code;
	@Column
	private Integer industry_id;
	@Column
	private Date dateTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getIndustry_id() {
		return industry_id;
	}

	public void setIndustry_id(Integer industry_id) {
		this.industry_id = industry_id;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
}
