package com.aiportal.dao;

import com.aiportal.model.InterviewHistory;
import com.aiportal.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InterviewHistoryDAO {

    // ==============================
    // SAVE INTERVIEW HISTORY
    // ==============================
    public boolean saveHistory(InterviewHistory history) {

        String sql = "INSERT INTO `interview history` "
                + "(user_id, topic, question, answer, feedback, score, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, CURDATE())";

       

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                System.out.println("ERROR: DATABASE CONNECTION IS NULL");
                return false;
            }

            

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                System.out.println("User ID: " + history.getUserId());
                System.out.println("Topic: " + history.getTopic());
                System.out.println("Question: " + history.getQuestion());
                System.out.println("Answer: " + history.getUserAnswer());
                System.out.println("Feedback: " + history.getFeedback());
                System.out.println("Score: " + history.getScore());

                ps.setInt(1, history.getUserId());
                ps.setString(2, history.getTopic());
                ps.setString(3, history.getQuestion());
                ps.setString(4, history.getUserAnswer());
                ps.setString(5, history.getFeedback());
                ps.setInt(6, history.getScore());

                int rows = ps.executeUpdate();

                System.out.println("ROWS INSERTED = " + rows);
                

                return rows > 0;
            }

        } catch (Exception e) {
            
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // GET HISTORY OF LOGGED-IN USER
    // ==============================
    public List<InterviewHistory> getHistoryByUser(int userId) {

        List<InterviewHistory> list = new ArrayList<>();

        String sql = "SELECT * FROM `interview history` "
                   + "WHERE user_id = ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    InterviewHistory history = new InterviewHistory(
                            rs.getInt("user_id"),
                            rs.getString("topic"),
                            rs.getString("question"),
                            rs.getString("answer"),
                            rs.getInt("score"),
                            rs.getString("feedback")
                    );

                    list.add(history);
                }
            }

        } catch (Exception e) {
           
            e.printStackTrace();
        }

        return list;
    }
  public double getOverallScoreByUser(int userId) {

    String sql =
        "SELECT CAST(AVG(score) AS DECIMAL(10,2)) AS overall_score "
      + "FROM `interview history` "
      + "WHERE user_id = ?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                double overallScore =
                        rs.getDouble("overall_score");

                System.out.println(
                    "OVERALL SCORE FROM DAO = " + overallScore
                );

                return overallScore;
            }
        }

    } catch (Exception e) {
       
        e.printStackTrace();
    }

    return 0.0;
}
}