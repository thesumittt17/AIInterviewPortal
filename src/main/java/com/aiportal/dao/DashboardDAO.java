package com.aiportal.dao;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

import com.aiportal.util.DBConnection;

import java.sql.*;


public class DashboardDAO {


public int getTotalInterviews(int userId){


String sql=
"SELECT COUNT(*) FROM `interview history` WHERE user_id=?";


try(Connection con=DBConnection.getConnection();
PreparedStatement ps=con.prepareStatement(sql)){


ps.setInt(1,userId);


ResultSet rs=ps.executeQuery();


if(rs.next())
return rs.getInt(1);


}catch(Exception e){

e.printStackTrace();

}


return 0;

}



public double getAverageScore(int userId) {

    String sql =
            "SELECT COALESCE(ROUND(AVG(score),2),0) AS avgScore " +
            "FROM `interview history` " +
            "WHERE user_id=?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getDouble("avgScore");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return 0.0;
}

public String getTopSkill(int userId){


String sql =
        "SELECT topic, COUNT(*) AS total "
      + "FROM `interview history` "
      + "WHERE user_id=? "
      + "GROUP BY topic "
      + "ORDER BY total DESC "
      + "LIMIT 1";


try(Connection con=DBConnection.getConnection();
PreparedStatement ps=con.prepareStatement(sql)){


ps.setInt(1,userId);


ResultSet rs=ps.executeQuery();


if(rs.next())
return rs.getString("topic");


}catch(Exception e){

e.printStackTrace();

}


return "N/A";

}

public int getHighestScore(int userId) {

    String sql =
"SELECT COALESCE(MAX(score),0) FROM `interview history` WHERE user_id=?";
    
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return 0;
}

public int getLowestScore(int userId) {

    String sql =
"SELECT COALESCE(MIN(score),0) FROM `interview history` WHERE user_id=?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return 0;
}


public String getBestTopic(int userId) {

    String sql =
"SELECT topic, ROUND(AVG(score),2) avgScore " +
"FROM `interview history` " +
"WHERE user_id=? " +
"GROUP BY topic " +
"ORDER BY avgScore DESC, COUNT(*) DESC " +
"LIMIT 1";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getString("topic");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return "N/A";
}


public String getWeakestTopic(int userId) {

    String sql =
"SELECT topic, ROUND(AVG(score),2) avgScore " +
"FROM `interview history` " +
"WHERE user_id=? " +
"GROUP BY topic " +
"ORDER BY avgScore ASC, COUNT(*) DESC " +
"LIMIT 1";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getString("topic");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return "N/A";
}

public List<Integer> getScoreHistory(int userId) {

    List<Integer> scores = new ArrayList<>();

    String sql =
            "SELECT score FROM `interview history` " +
            "WHERE user_id=? " +
            "ORDER BY id ASC";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            scores.add(rs.getInt("score"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return scores;
}



public Map<String, Double> getTopicWiseAverage(int userId) {

    Map<String, Double> map = new LinkedHashMap<>();

    String sql =
            "SELECT topic, ROUND(AVG(score),2) avgScore " +
            "FROM `interview history` " +
            "WHERE user_id=? " +
            "GROUP BY topic " +
            "ORDER BY topic";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

    System.out.println(
        rs.getString("topic") + " -> " +
        rs.getDouble("avgScore")
    );

    map.put(
        rs.getString("topic"),
        rs.getDouble("avgScore")
    );
}

    } catch (Exception e) {
        e.printStackTrace();
    }

    return map;
}

}