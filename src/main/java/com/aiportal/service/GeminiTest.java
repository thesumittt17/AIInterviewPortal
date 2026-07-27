package com.aiportal.service;

import com.google.genai.Client;

public class GeminiTest {

    public static void main(String[] args) {

        String apiKey = System.getenv("GEMINI_API_KEY");

        Client client = Client.builder()
                .apiKey(apiKey)
                .build();

        System.out.println("Gemini SDK Loaded Successfully!");
    }
}