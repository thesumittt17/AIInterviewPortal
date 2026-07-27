package com.aiportal.model;

public class InterviewHistory {

    private int id;
    private int userId;
    private String topic;
    private String question;
    private String userAnswer;
    private int score;
    private String feedback;

    public InterviewHistory(int userId, String topic, String question,
                            String userAnswer, int score, String feedback) {
        this.userId = userId;
        this.topic = topic;
        this.question = question;
        this.userAnswer = userAnswer;
        this.score = score;
        this.feedback = feedback;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getTopic() {
        return topic;
    }

    public String getQuestion() {
        return question;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public int getScore() {
        return score;
    }

    public String getFeedback() {
        return feedback;
    }
}