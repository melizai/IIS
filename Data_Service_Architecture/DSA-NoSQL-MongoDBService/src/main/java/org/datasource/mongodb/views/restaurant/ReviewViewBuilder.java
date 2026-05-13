package org.datasource.mongodb.views.restaurant;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.datasource.mongodb.MongoDataSourceConnector;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReviewViewBuilder {

    private List<ReviewView> reviewViewList;

    public List<ReviewView> getReviewViewList() {
        return reviewViewList;
    }

    private MongoDataSourceConnector dataSourceConnector;

    public ReviewViewBuilder(MongoDataSourceConnector dataSourceConnector) {
        this.dataSourceConnector = dataSourceConnector;
    }

    public ReviewViewBuilder build() throws Exception {
        return this.select();
    }

    public ReviewViewBuilder select() throws Exception {
        MongoDatabase db = dataSourceConnector.getMongoDatabase();

        MongoCollection<ReviewView> reviewsCollection =
                db.getCollection("reviews", ReviewView.class);

        this.reviewViewList = new ArrayList<>();

        reviewsCollection.find().into(this.reviewViewList);

        reviewViewList.forEach(System.out::println);

        return this;
    }
}