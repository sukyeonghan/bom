package com.kh.bom.common.typehandler;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class DateStringTypeHandler implements TypeHandler<Date>{
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	public void setParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		ps.setDate(i,parameter);
	}

	@Override
	public Date getResult(ResultSet rs, String columnName) throws SQLException {
	
		String day=rs.getString(columnName);
		java.util.Date d=new java.util.Date();
		try {
			d = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(day);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		java.sql.Date date = new java.sql.Date(d.getTime());
		return date;
		
	
	}

	@Override
	public Date getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		String str=rs.getString(columnIndex);
		Date date=Date.valueOf(str);
		return date;
	}

	@Override
	public Date getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		String str=cs.getString(columnIndex);
		Date date=Date.valueOf(str);
		return date;
		
	}
	
	
	

}
