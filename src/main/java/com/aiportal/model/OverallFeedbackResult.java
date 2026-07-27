package com.aiportal.model;

import java.util.List;

public class OverallFeedbackResult {

    private String performanceSummary;
    private List<String> strengths;
    private List<String> weaknesses;
    private List<String> areasForImprovement;

    public OverallFeedbackResult() {
    }

    public String getPerformanceSummary() {
        return performanceSummary;
    }

    public void setPerformanceSummary(String performanceSummary) {
        this.performanceSummary = performanceSummary;
    }

    public List<String> getStrengths() {
        return strengths;
    }

    public void setStrengths(List<String> strengths) {
        this.strengths = strengths;
    }

    public List<String> getWeaknesses() {
        return weaknesses;
    }

    public void setWeaknesses(List<String> weaknesses) {
        this.weaknesses = weaknesses;
    }

    public List<String> getAreasForImprovement() {
        return areasForImprovement;
    }

    public void setAreasForImprovement(
            List<String> areasForImprovement) {
        this.areasForImprovement = areasForImprovement;
    }
}