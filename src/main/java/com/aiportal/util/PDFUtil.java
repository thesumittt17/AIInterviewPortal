package com.aiportal.util;

import java.io.InputStream;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class PDFUtil {

    public static String extractText(InputStream inputStream) {

        try {

            PDDocument document =
                    Loader.loadPDF(inputStream.readAllBytes());

            PDFTextStripper stripper =
                    new PDFTextStripper();

            String text = stripper.getText(document);

            document.close();

            return text;

        } catch (Exception e) {

            e.printStackTrace();

            return "";

        }
    }
}