package com.kh.bom.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class StringArrayTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		if(parameter != null) {
			String value=String.join(",", parameter);//,으로 배열을 연결해 stirng으로 바꿈
			ps.setString(i, value); //(index,value)
		}else {
			ps.setString(i, "");
		}
	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		String temp=rs.getString(columnName);
		if(temp!=null) {
			return rs.getString(columnName).split(",");
		}
		return null;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		//return rs.getString(columnIndex).split(",");
		String temp=rs.getString(columnIndex);
		if(temp!=null) {
			return rs.getString(columnIndex).split(",");
		}
		return null;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		//return cs.getString(columnIndex).split(",");
		String temp=cs.getString(columnIndex);
		if(temp!=null) {
			return cs.getString(columnIndex).split(",");
		}
		return null;
	}

}
