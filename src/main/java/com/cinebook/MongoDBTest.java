package com.cinebook;

import org.bson.Document;

public class MongoDBTest {

    public static void main(String[] args) {

        try {
            MongoDBConnection.getDatabase()
                .runCommand(new Document("ping", 1));

            System.out.println("MongoDB Connected Successfully!");

        } catch (Exception e) {
            System.out.println("MongoDB Connection Failed!");
            e.printStackTrace();
        }
    }
}