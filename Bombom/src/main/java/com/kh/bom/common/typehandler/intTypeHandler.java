package com.kh.bom.common.typehandler;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class intTypeHandler implements TypeHandler<Integer[]> {

	
	@Override
	public void setParameter(PreparedStatement ps, int i, Integer[] parameter, JdbcType jdbcType) throws SQLException {
		
		if(parameter != null) {
			String value=String.join(",", String.valueOf(parameter));
			ps.setString(i, value);
			/*
			 * for(int iv: parameter) { ps.setInt(i,iv); }
			 */
		}else {
			/* ps.setInt(i,0); */
			ps.setString(i,"");
		}
		
	}
	
	//get할 때 mybatis가 셋 중 하나 골라서 가져옴
	//다시 배열로 만듦
	//위 결과가 columName으로 넘어옴
	@Override
	public Integer[] getResult(ResultSet rs, String columnName) throws SQLException {
		String[] temp=rs.getString(columnName).split(",");
		int[] a = Arrays.stream(temp).mapToInt(Integer::parseInt).toArray();
		Integer b[] = Arrays.stream(a).boxed().toArray(Integer[]::new); 
	
		return b;
	}

	@Override
	public Integer[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String[] temp=rs.getString(columnIndex).split(",");
		int[] a = Arrays.stream(temp).mapToInt(Integer::parseInt).toArray();
		Integer b[] = Arrays.stream(a).boxed().toArray(Integer[]::new);
		return b;
	}

	@Override
	public Integer[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String[] temp=cs.getString(columnIndex).split(",");
		int[] a = Arrays.stream(temp).mapToInt(Integer::parseInt).toArray();
		Integer b[] = Arrays.stream(a).boxed().toArray(Integer[]::new);
		return b;
	}
	

	

}
