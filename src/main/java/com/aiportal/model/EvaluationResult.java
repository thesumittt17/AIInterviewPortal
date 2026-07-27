package com.aiportal.model;


import java.util.List;

public class EvaluationResult {

    private int score;
    private String feedback;

    // New Fields
    private List<String> strengths;
    private List<String> weaknesses;
    private List<String> missingPoints;

    private String betterAnswer;
    private String difficulty;
    private String confidence;

    public EvaluationResult() {
    }

    // ==========================
    // Score
    // ==========================
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    // ==========================
    // Feedback
    // ==========================
    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    // ==========================
    // Strengths
    // ==========================
    public List<String> getStrengths() {
        return strengths;
    }

    public void setStrengths(List<String> strengths) {
        this.strengths = strengths;
    }

    // ==========================
    // Weaknesses
    // ==========================
    public List<String> getWeaknesses() {
        return weaknesses;
    }

    public void setWeaknesses(List<String> weaknesses) {
        this.weaknesses = weaknesses;
    }

    // ==========================
    // Missing Points
    // ==========================
    public List<String> getMissingPoints() {
        return missingPoints;
    }

    public void setMissingPoints(List<String> missingPoints) {
        this.missingPoints = missingPoints;
    }

    // ==========================
    // Better Answer
    // ==========================
    public String getBetterAnswer() {
        return betterAnswer;
    }

    public void setBetterAnswer(String betterAnswer) {
        this.betterAnswer = betterAnswer;
    }

    // ==========================
    // Difficulty
    // ==========================
    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    // ==========================
    // Confidence
    // ==========================
    public String getConfidence() {
        return confidence;
    }

    public void setConfidence(String confidence) {
        this.confidence = confidence;
    }
}