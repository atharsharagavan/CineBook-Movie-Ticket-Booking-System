package com.cinebook;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class MongoDBConnection {

    private static final String URI =
            System.getenv().getOrDefault(
                    "MONGODB_URI",
                    "mongodb://localhost:27017"
            );

    private static final MongoClient CLIENT =
            MongoClients.create(URI);

    public static MongoDatabase getDatabase() {
        return CLIENT.getDatabase("cinebook");
    }
}