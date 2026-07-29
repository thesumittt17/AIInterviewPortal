package com.aiportal.dao;

import com.aiportal.model.User;
import com.aiportal.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    Connection con = null;

    PreparedStatement ps = null;

    ResultSet rs = null;

    // Register User
  public boolean registerUser(User user) {

    try (Connection con = DBConnection.getConnection()) {

        System.out.println("Connection = " + con);

        String sql = "INSERT INTO users(name,email,password) VALUES(?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        System.out.println("Name = " + user.getName());
        System.out.println("Email = " + user.getEmail());
        System.out.println("Password = " + user.getPassword());

        ps.setString(1, user.getName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());

        int rows = ps.executeUpdate();

        System.out.println("Rows Inserted = " + rows);

        return rows > 0;

    } catch (Exception e) {
    
    e.printStackTrace();
    throw new RuntimeException(e);
}
}
    
    public User loginUser(String email,String password){

    User user=null;

    try{

        con=DBConnection.getConnection();

        String sql="SELECT * FROM users WHERE email=? AND password=?";

        ps=con.prepareStatement(sql);

        ps.setString(1,email);

        ps.setString(2,password);

        rs=ps.executeQuery();



if(rs.next()){



    user=new User();

    user.setId(rs.getInt("id"));
    user.setName(rs.getString("name"));
    user.setEmail(rs.getString("email"));
    user.setPassword(rs.getString("password"));

}
else{

    System.out.println("USER NOT FOUND");

}

    }
    catch(Exception e){

        e.printStackTrace();

    }

    return user;

}
    
    public User findByEmail(String email){

    User user=null;

    try{

        con=DBConnection.getConnection();

        String sql="SELECT * FROM users WHERE email=?";

        ps=con.prepareStatement(sql);

        ps.setString(1,email);

        rs=ps.executeQuery();

        if(rs.next()){

            user=new User();

            user.setId(rs.getInt("id"));

            user.setName(rs.getString("name"));

            user.setEmail(rs.getString("email"));

            user.setPassword(rs.getString("password"));

        }

    }
    catch(Exception e){

        e.printStackTrace();

    }

    return user;

}

    
}