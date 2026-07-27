package com.aiportal.service;
import com.aiportal.model.ResumeAnalysisResult;
import com.aiportal.model.EvaluationResult;
import com.google.gson.Gson;
import com.google.genai.Client;
import com.google.genai.types.GenerateContentResponse;
import com.aiportal.model.InterviewHistory;
import com.aiportal.model.OverallFeedbackResult;




public class GeminiService {

    
    public GeminiService() {
    System.out.println("Gemini Key Loaded: " + (API_KEY != null));
}
    
   private String API_KEY = System.getenv("GEMINI_API_KEY");
     
    

  public String generateQuestion(String topic, String previousQuestion) {

    try {
        Client client = Client.builder()
                .apiKey(API_KEY)
                .build();
String previous =
        previousQuestion == null ? "None" : previousQuestion;


String prompt =
        "Generate one unique " + topic +
        " interview question for a fresher.\n" +
        "Return only the question.\n" +
        "Avoid repeating this previous question:\n" +
        previous;

        GenerateContentResponse response =
                client.models.generateContent(
                        "gemini-flash-lite-latest",
                        prompt,
                        null
                );

        return response.text().trim();

    } catch(Exception e){
    e.printStackTrace();
    return "ERROR: " + e.getMessage();
}


    }
    
    public EvaluationResult evaluateAnswer(
        String topic,
        String question,
        String answer) {

    try {

        Client client = Client.builder()
                .apiKey(API_KEY)
                .build();

       String prompt =
"You are an experienced Senior Technical Interviewer at top software companies such as Google, Microsoft, Amazon, and Oracle.\n\n"

+ "Evaluate the candidate's answer fairly and professionally.\n"
+ "Consider the following criteria:\n"
+ "1. Technical correctness\n"
+ "2. Completeness of the answer\n"
+ "3. Clarity of explanation\n"
+ "4. Practical understanding\n"
+ "5. Use of correct technical terminology\n\n"

+ "Topic: " + topic + "\n"
+ "Question: " + question + "\n"
+ "Candidate Answer: " + answer + "\n\n"

+ "SCORING RULES:\n"
+ "- Score MUST be an INTEGER between 0 and 100.\n"
+ "- Give scores realistically. Do NOT be overly strict.\n"
+ "- Reserve scores below 20 ONLY for blank, irrelevant, or completely incorrect answers.\n"
+ "- Even if an answer is partially correct, it should normally receive at least 40-60 marks.\n"
+ "- A technically correct answer with minor mistakes should receive 75-90 marks.\n"
+ "- An excellent interview-quality answer should receive 90-100 marks.\n\n"

+ "Score Guide:\n"
+ "90-100 = Excellent (Complete, technically correct, interview-ready)\n"
+ "75-89 = Good (Mostly correct with minor omissions)\n"
+ "60-74 = Average (Correct but missing important details)\n"
+ "40-59 = Basic Understanding (Some correct concepts but incomplete)\n"
+ "20-39 = Weak (Major mistakes or very limited understanding)\n"
+ "0-19 = Very Poor (Incorrect, irrelevant, or blank answer)\n\n"

+ "Provide constructive feedback explaining WHY the score was awarded.\n"
+ "Suggest improvements wherever necessary.\n\n"

+ "Return ONLY valid JSON.\n"
+ "Do NOT return Markdown.\n"
+ "Do NOT return explanation outside JSON.\n\n"

+ "Use EXACTLY this JSON format:\n"

+ "{\n"
+ "  \"score\": 85,\n"
+ "  \"feedback\": \"Overall evaluation in 2-3 sentences.\",\n"
+ "  \"strengths\": [\"Strength 1\", \"Strength 2\"],\n"
+ "  \"weaknesses\": [\"Weakness 1\", \"Weakness 2\"],\n"
+ "  \"missingPoints\": [\"Missing Point 1\", \"Missing Point 2\"],\n"
+ "  \"betterAnswer\": \"Provide a professional interview-quality answer.\",\n"
+ "  \"difficulty\": \"Easy | Medium | Hard\",\n"
+ "  \"confidence\": \"High | Medium | Low\"\n"
+ "}";
        GenerateContentResponse response =
                client.models.generateContent(
                        "gemini-flash-lite-latest",
                        prompt,
                        null
                );

        String json = response.text().trim();
        
       


        // Remove markdown fences if Gemini adds them accidentally
        json = json.replace("```json", "")
                   .replace("```", "")
                   .trim();

        Gson gson = new Gson();

        return gson.fromJson(json, EvaluationResult.class);

    } catch (Exception e) {

    e.printStackTrace();

    EvaluationResult errorResult = new EvaluationResult();

    errorResult.setScore(0);

    errorResult.setFeedback(
            "Unable to evaluate the answer."
    );

    errorResult.setStrengths(
            java.util.Collections.emptyList()
    );

    errorResult.setWeaknesses(
            java.util.Collections.emptyList()
    );

    errorResult.setMissingPoints(
            java.util.Collections.emptyList()
    );

    errorResult.setBetterAnswer(
            "Please try submitting your answer again."
    );

    errorResult.setDifficulty("Unknown");

    errorResult.setConfidence("Low");

    return errorResult;
}
}
    
    public OverallFeedbackResult generateOverallFeedback(
        java.util.List<InterviewHistory> historyList,
        double overallScore) {

    try {

        // Check if interview history is empty
        if (historyList == null || historyList.isEmpty()) {

            OverallFeedbackResult emptyResult =
                    new OverallFeedbackResult();

            emptyResult.setPerformanceSummary(
                    "No interview history available."
            );

            emptyResult.setStrengths(
                    java.util.Collections.emptyList()
            );

            emptyResult.setWeaknesses(
                    java.util.Collections.emptyList()
            );

            emptyResult.setAreasForImprovement(
                    java.util.Collections.emptyList()
            );

            return emptyResult;
        }


        // Create Gemini client
        Client client = Client.builder()
                .apiKey(API_KEY)
                .build();


        // Prepare complete interview data
        StringBuilder interviewData =
                new StringBuilder();


       int count = 0;

for (InterviewHistory history : historyList) {

    if (count >= 10) {
        break;   // Analyze only the latest 10 interviews
    }

    interviewData.append("Topic: ")
            .append(history.getTopic())
            .append("\n");

    interviewData.append("Question: ")
            .append(history.getQuestion())
            .append("\n");

    interviewData.append("Candidate Answer: ")
            .append(history.getUserAnswer())
            .append("\n");

    interviewData.append("Score: ")
            .append(history.getScore())
            .append("/100\n");

    interviewData.append("AI Feedback: ")
            .append(history.getFeedback())
            .append("\n\n");

    count++;
}


        // Prompt for structured feedback
        String prompt =
                "You are a professional technical interviewer.\n\n" +

                "Analyze the candidate's complete interview performance.\n\n" +

                "Overall Score: "
                + String.format("%.1f", overallScore)
                + "/10\n\n" +

                "Interview Data:\n"
                + interviewData.toString() +

                "\nReturn ONLY valid JSON.\n" +

                "Do not use markdown.\n" +
                "Do not use ```json blocks.\n\n" +

                "Use exactly this JSON structure:\n" +

                "{\n" +

                "  \"performanceSummary\": "
                + "\"Short overall performance summary\",\n" +

                "  \"strengths\": "
                + "[\"Strength 1\", \"Strength 2\"],\n" +

                "  \"weaknesses\": "
                + "[\"Weakness 1\", \"Weakness 2\"],\n" +

                "  \"areasForImprovement\": "
                + "[\"Area 1\", \"Area 2\"]\n" +

                "}\n\n" +

                "Keep the feedback professional, constructive "
                + "and suitable for a fresher.";


        // Call Gemini API
        GenerateContentResponse response =
                client.models.generateContent(
                        "gemini-flash-lite-latest",
                        prompt,
                        null
                );


        // Get Gemini response
        String json =
                response.text().trim();


        // Remove markdown if Gemini adds it
        json = json
                .replace("```json", "")
                .replace("```", "")
                .trim();


        

        

        

        // Convert JSON into Java object
        Gson gson =
                new Gson();


        OverallFeedbackResult result =
                gson.fromJson(
                        json,
                        OverallFeedbackResult.class
                );


        return result;


    } catch (Exception e) {


        


        e.printStackTrace();


        // Return safe fallback result
        OverallFeedbackResult errorResult =
                new OverallFeedbackResult();


        errorResult.setPerformanceSummary(
                "Unable to generate overall AI feedback at this time."
        );


        errorResult.setStrengths(
                java.util.Collections.emptyList()
        );


        errorResult.setWeaknesses(
                java.util.Collections.emptyList()
        );


        errorResult.setAreasForImprovement(
                java.util.Collections.emptyList()
        );


        return errorResult;
    }
}
    public ResumeAnalysisResult analyzeResume(String resumeText) {

    try {

        Client client = Client.builder()
                .apiKey(API_KEY)
                .build();

        String prompt =
"You are an expert ATS Resume Reviewer and Technical Interviewer.\n\n"

+ "Analyze the following resume.\n\n"

+ resumeText + "\n\n"

+ "Return ONLY valid JSON.\n"

+ "Do NOT write any explanation.\n"

+ "Do NOT write markdown.\n"

+ "Do NOT use triple backticks.\n"

+ "Every field must be present.\n"

+ "Scores must be integers.\n\n"

+ "{\n"

+ "\"resumeScore\":90,\n"

+ "\"atsScore\":85,\n"

+ "\"strengths\":[\"Java\",\"Projects\"],\n"

+ "\"weaknesses\":[\"No Internship\"],\n"

+ "\"missingSkills\":[\"Docker\",\"Spring Security\"],\n"

+ "\"suggestions\":[\"Improve Projects\",\"Add GitHub\"],\n"

+ "\"recommendedTopics\":[\"Java\",\"SQL\",\"DBMS\",\"OOPS\"]\n"

+ "}";

        GenerateContentResponse response =
                client.models.generateContent(
                        "gemini-flash-lite-latest",
                        prompt,
                        null
                );

        String json = response.text();

        System.out.println("===== GEMINI RAW RESPONSE =====");
System.out.println(json);
System.out.println("================================");
        
if (json == null || json.trim().isEmpty()) {
    throw new RuntimeException("Gemini returned empty response.");
}

json = json.trim();




        json = json.replace("```json", "")
                   .replace("```", "")
                   .trim();

        Gson gson = new Gson();

       ResumeAnalysisResult result =
        gson.fromJson(json, ResumeAnalysisResult.class);

       System.out.println("Resume Score = " + result.getResumeScore());
System.out.println("ATS Score = " + result.getAtsScore());
System.out.println("Strengths = " + result.getStrengths());
System.out.println("Weaknesses = " + result.getWeaknesses());
System.out.println("Missing Skills = " + result.getMissingSkills());
       
System.out.println("Resume Score = " + result.getResumeScore());

return result;

    } catch (Exception e) {

       
e.printStackTrace();

        ResumeAnalysisResult result =
                new ResumeAnalysisResult();

        result.setResumeScore(0);
        result.setAtsScore(0);

        result.setStrengths(
                java.util.Collections.emptyList());

        result.setWeaknesses(
                java.util.Collections.emptyList());

        result.setMissingSkills(
                java.util.Collections.emptyList());

        result.setSuggestions(
                java.util.Collections.emptyList());

        result.setRecommendedTopics(
                java.util.Collections.emptyList());

        return result;

    }

}
}
